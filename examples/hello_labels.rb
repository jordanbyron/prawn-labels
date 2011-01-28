require File.join(File.dirname(__FILE__), "example_helper")

fancy_names = ["Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]

Prawn::Labels.generate("hello_labels.pdf", fancy_names,:outline => true,:type => "tyton") do |pdf, name|
  pdf.pad(10) do
    pdf.text name, :align => :center
  end
  
end
