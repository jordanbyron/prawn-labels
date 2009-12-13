require 'prawn/layout'

module Prawn
  class Document
    
    def labels(data, options={}, &block)
      @labels = Labels.new(data,options,&block)
    end
    
    
    class Labels
      attr_reader :labels, :data
      
      # Creates the label grid and a label object for each data element
      def initialize(data, options = {}, &block)
        @data = data
        
        generate_labels
        
        define_grid
      end
  
      class Label
        attr_reader :data
        
        def initialize(data)
          @data = data
        end
      end
  
      private
  
      def generate_labels
        @labels = []
    
        @data.each do |d|
          @labels << Label.new(data)
        end
      end
    end
  end
end