require File.join(File.dirname(__FILE__), "example_helper")
 
Prawn::Document.generate("hello_labels.pdf") do
  data = ["Label 1", "Label 2", "Label 3"]

  # This will setup the documents margins according to the specified type
  # then loop through the provided data
  #
  labels data, :type => "Avery5160" do |label|
    text label.data
  end
end