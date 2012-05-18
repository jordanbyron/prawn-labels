require File.join(File.dirname(__FILE__), "example_helper")

fancy_names = ["Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]

#define a custom label type
my_custom_types  = {"Agipa119461"=>{"paper_size"=>"A4", "top_margin"=>36.57, "bottom_margin"=>0, "left_margin"=>20.551, "right_margin"=>20.551, "columns"=>3, "rows"=>8, "column_gutter"=>7.087, "row_gutter"=>0}} 

Prawn::Labels.generate("custom_labels_1.pdf", fancy_names,  :custom_types => my_custom_types, :type => "Agipa119461") do |pdf, name|
  pdf.text name
end

#use a configuration file for custom labels
my_custom_types_file_name = File.join(File.dirname(__FILE__), "custom_label.yml") 

Prawn::Labels.generate("custom_labels_2.pdf", fancy_names,  :custom_types => my_custom_types_file_name, :type => "Agipa119461") do |pdf, name|
  pdf.text name
end
