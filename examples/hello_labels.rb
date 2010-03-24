require File.join(File.dirname(__FILE__), "example_helper")

fancy_names = ["Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]

Prawn::Labels.generate("hello_labels.pdf", fancy_names, :type => "Avery5160") do |pdf, name|
  pdf.text name
end