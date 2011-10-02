# labels.rb :  A simple helper to generate labels for Prawn PDFs
#
# Copyright February 2010, Jordan Byron. All Rights Reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

require 'prawn'
require 'yaml'

module Prawn
  class Labels
    attr_reader :document, :type

    def self.generate(file_name, data, options = {}, &block)
      labels = Labels.new(data, options, &block)
      labels.document.render_file(file_name)
    end

    def self.render(data, options = {}, &block)
      labels = Labels.new(data, options, &block)
      labels.document.render
    end

    def initialize(data, options = {}, &block)
      types_file = File.join(File.dirname(__FILE__), 'types.yaml')
      types      = YAML.load_file(types_file)

      unless @type = types[options[:type]]
        raise "Label Type Unknown '#{options[:type]}'"
      end

      type["paper_size"] ||= "A4"
      type["top_margin"] ||= 36
      type["left_margin"] ||= 36
      @rotated = !!type["rotated"]

      @document = Document.new  :page_size      => type["paper_size"],
                                :top_margin     => type["top_margin"],
                                :bottom_margin  => type["bottom_margin"],
                                :left_margin    => type["left_margin"],
                                :right_margin   => type["right_margin"]

      generate_grid @type

      data.each_with_index do |record, i|
        create_label(i, record, options) do |pdf, record|
          yield pdf, record
        end
      end

    end

    private

    def generate_grid(type)
      @document.define_grid({ :columns       => type["columns"],
                              :rows          => type["rows"],
                              :column_gutter => type["column_gutter"],
                              :row_gutter    => type["row_gutter"],
                            })
    end

    def row_col_from_index(i)
      page, newi = i.divmod(@document.grid.rows * @document.grid.columns)
      if newi == 0 and page > 0
        @document.start_new_page
        generate_grid @type
        return [0,0]
      end
      return newi.divmod(@document.grid.columns)
    end

    def create_label(i, record, options = {},  &block)
      p = row_col_from_index(i)

      shrink_text(record) if options[:shrink_to_fit] == true

      b = @document.grid(p.first, p.last)
      @document.bounding_box b.top_left, :width => b.width, :height => b.height do
        if @rotated
          @document.rotate(270, :origin => b.top_left) do
            @document.translate(0, b.width) do
              yield @document, record
            end
          end
        else
          yield @document, record
        end
      end
    end

    def shrink_text(record)
      linecount = (split_lines = record.split("\n")).length

      # 30 is estimated max character length per line.
      split_lines.each {|line| linecount += line.length / 30 }

      # -10 accounts for the overflow margins
      rowheight = @document.grid.row_height - 10

      if linecount <= rowheight / 12.floor
        @document.font_size = 12
      else
        @document.font_size = rowheight / (linecount + 1)
      end
    end
  end
end
