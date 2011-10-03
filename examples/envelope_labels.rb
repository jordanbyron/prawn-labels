require File.join(File.dirname(__FILE__), "example_helper")

fancy_names = ["Jordan With a long address\n that goes over multiple lines blah blah blah",
               "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]

Prawn::Labels.generate("envelope_labels.pdf", fancy_names, :type => "Envelope10") do |pdf, name|
  pdf.text name
end
