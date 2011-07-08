# Prawn/Labels: A simple helper to generate labels for Prawn PDFs

Prawn/Labels takes the guess work out of generating labels using Prawn

## Usage

```ruby
require 'prawn/labels'

names = ["Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]

# Create and save a PDF file
Prawn::Labels.generate("names.pdf", names, :type => "Avery5160") do |pdf, name|
  pdf.text name
end

# Render a PDF file and send to browser
labels = Prawn::Labels.render(names, :type => "Avery5160") do |pdf, name|
  pdf.text name
end
send_data labels, :filename => "names.pdf", :type => "application/pdf"

# Scale text to fit label
Prawn::Labels.generate("names.pdf", names, :type => "Avery5160", :shrink_to_fit => true) do |pdf, name|
  pdf.text name
end
```

This creates a document with a name from the names array in each label. The labels will be formatted for Avery 5160 labels. Formats are defined in the prawn/labels/types.yaml file.

For a full list of examples, take a look in the `examples` folder.

## Contributors

Jordan Byron <http://jordanbyron.com>
David Speake <david@verycleverstuff.co.uk>
Carlo Biedenharn <cbieden@mit.edu>
