# labels.rb :  A simple helper to generate labels for Prawn PDFs
#
# Copyright February 2010, Jordan Byron. All Rights Reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

require 'prawn/layout'

module Prawn    
  class Labels
    attr_reader :document, :type
    
    def self.generate(file_name, options = {}, &block)                               
      labels = Labels.new(options,&block)
      
      labels.document.render_file(file_name)
    end
    
    def initialize(options={}, &block)
      types_file = File.join(File.dirname(__FILE__), 'types.yaml')
      types      = YAML.load_file(types_file)
      
      unless type = types[options[:type]]
        raise "Label Type Unknown '#{options[:type]}'" 
      end
      
      @document = Document.new  :left_margin  => type["left_margin"], 
                                :right_margin => type["right_margin"]
                                
      generate_grid type
      
      create_labels do |pdf,cell|
        yield pdf,cell
      end
      
    end
    
    private
    
    def generate_grid(type)
      
      @document.instance_eval do
        define_grid  :columns       => type["columns"], 
                     :rows          => type["rows"], 
                     :column_gutter => type["column_gutter"],
                     :row_gutter    => type["row_gutter"]
      end
    end
  
    def create_labels(&block)
      @document.grid.rows.times do |i|
        @document.grid.columns.times do |j|
          b = @document.grid(i,j)
          @document.bounding_box b.top_left, :width => b.width, :height => b.height do
            yield(@document, b)
          end
        end
      end
    end
  end
end