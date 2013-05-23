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

    class << self

      def generate(file_name, data, options = {}, &block)
        labels = Labels.new(data, options, &block)
        labels.document.render_file(file_name)
      end

      def render(data, options = {}, &block)
        labels = Labels.new(data, options, &block)
        labels.document.render
      end

      def types=(custom_types)
        if custom_types.is_a? Hash
          types.merge! custom_types
        elsif custom_types.is_a?(String) && File.exist?(custom_types)
          types.merge! YAML.load_file(custom_types)
        end
      end

      def types
        @types ||= begin
          types_file = File.join(File.dirname(__FILE__), 'types.yaml')
          YAML.load_file(types_file)
        end
      end

    end

    def initialize(data, options = {}, &block)
      unless @type = Labels.types[options[:type]]
        raise "Label Type Unknown '#{options[:type]}'"
      end

      type["paper_size"]  ||= "A4"
      type["top_margin"]  ||= 36
      type["left_margin"] ||= 36
      
      options[:document] ||= {}
      
      if options[:document][:page_layout] == :landscape
        type["top_margin"],type["right_margin"],type["bottom_margin"],type["left_margin"] = type["left_margin"],type["top_margin"],type["right_margin"],type["bottom_margin"]
        type["columns"],type["rows"] = type["rows"],type["columns"]
        type["column_gutter"],type["row_gutter"] = type["row_gutter"],type["column_gutter"]
      end
      options.merge!(:vertical_text => true) if type["vertical_text"]

      @document = Document.new  options[:document].merge(
                                :page_size      => type["paper_size"],
                                :top_margin     => type["top_margin"],
                                :bottom_margin  => type["bottom_margin"],
                                :left_margin    => type["left_margin"],
                                :right_margin   => type["right_margin"])
                                
      generate_grid @type

      data.each_with_index do |record, index|
        if (defined? record.vertical_text)
          options.merge!(:vertical_text => record.vertical_text)
        end
        create_label(index, record, options) do |pdf, record|
          yield pdf, record
        end
      end

    end

    private

    def generate_grid(type)
      @document.define_grid({ :columns       => type["columns"],
                              :rows          => type["rows"],
                              :column_gutter => type["column_gutter"],
                              :row_gutter    => type["row_gutter"]
                            })
    end

    def row_col_from_index(index)
      page, new_index = index.divmod(@document.grid.rows * @document.grid.columns)
      if new_index == 0 and page > 0
        @document.start_new_page
        generate_grid @type
        return [0,0]
      end
      return new_index.divmod(@document.grid.columns)
    end

    def create_label(index, record, options = {},  &block)
      p = row_col_from_index(index)

      shrink_text(record) if options[:shrink_to_fit] == true

      b = @document.grid(p.first, p.last)

      if options[:vertical_text]
        @document.rotate(270, :origin => b.top_left) do
          @document.translate(0, b.width) do
            @document.bounding_box b.top_left, :width => b.height, :height => b.width do
              yield @document, record
            end
          end
        end
      else
        @document.bounding_box b.top_left, :width => b.width, :height => b.height do
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
