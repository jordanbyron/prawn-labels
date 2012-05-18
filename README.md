# Prawn/Labels: A simple helper to generate labels for Prawn PDFs

Prawn/Labels takes the guess work out of generating labels using Prawn ~> 0.11.1

## Install

```bash
$ gem install prawn-labels
```

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

# Create custom labels

So you will not need to fork the Gem just to have your own formats you can pass the library a file name or a hash as so:
```ruby
my_custom_types_file_name = File.join(File.dirname(__FILE__), "config/custom_types.yaml") 

Prawn::Labels.generate("names.pdf", names, :custom_types => my_custom_types_file_name :type => "Avery5160") do |pdf, name|
  pdf.text name
end
```
or alternatively:
```ruby
my_custom_types  = {"Agipa119461"=>{"paper_size"=>"A4", "top_margin"=>36.57, "bottom_margin"=>0, "left_margin"=>20.551, "right_margin"=>20.551, "columns"=>3, "rows"=>8, "column_gutter"=>7.087, "row_gutter"=>0}} 

Prawn::Labels.generate("names.pdf", names, :custom_types => my_custom_types, :type => "Agipa119461") do |pdf, name|
  pdf.text name
end
```

## Contributors

- [Jordan Byron](http://jordanbyron.com)
- [David Speake](mailto:david@verycleverstuff.co.uk)
- [Carlo Biedenharn](mailto:cbieden@mit.edu)
- [Forrest Zeisler](https://github.com/forrest)
- [Jack Twilley](https://github.com/mathuin)
