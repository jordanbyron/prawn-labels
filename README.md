# Prawn/Labels: A simple label generator for Prawn PDFs

Prawn/Labels takes the guess work out of generating labels using Prawn >= 0.12.0

## Install

Using RubyGems

```bash
$ gem install prawn-labels
```

Using Bundler

```ruby
gem "prawn-labels"
```

## Usage

We've tried to make generating labels as simple as possible with Prawn::Labels.
If you have an object which responds to `each`, then you're in business.

### Create and save a PDF file

```ruby
require 'prawn/labels'

names = ["Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]

Prawn::Labels.generate("names.pdf", names, :type => "Avery5160") do |pdf, name|
  pdf.text name
end
```

This creates a document with a name from the names array in each label. The labels will be formatted for Avery 5160 labels. Formats are defined in the `prawn/labels/types.yaml` file, or by [loading a custom hash or yaml file](#custom-label-types)

For a full list of examples, take a look in the `examples` folder.

### Render a PDF file and send to browser

```ruby
labels = Prawn::Labels.render(names, :type => "Avery5160") do |pdf, name|
  pdf.text name
end

send_data labels, :filename => "names.pdf", :type => "application/pdf"
```

### Scale text to fit label

```ruby
Prawn::Labels.generate( "names.pdf", names, :type => "Avery5160",
                        :shrink_to_fit => true) do |pdf, name|
  pdf.text name
end
```

### Custom label types

If the label type you need to use isn't defined in `prawn/labels/types.yaml`
file, you can define and load your own.

```ruby
Prawn::Labels.types = '/path/to/custom/types.yaml'

Prawn::Labels.generate("names.pdf", names, :type => "Custom123") do |pdf, name|
  pdf.text name
end
```

or using a hash:

```ruby
Prawn::Labels.types = {
  "QuarterSheet" => {
    "paper_size" => "A4",
    "columns"    => 2,
    "rows"       => 2
}}

Prawn::Labels.generate("names.pdf", names, :type => "QuarterSheet") do |pdf, name|
  pdf.text name
end
```

### Prawn document options

Prawn::Labels allows passing a hash of document options all the way through to Prawn. 

```ruby
require 'prawn/labels'

names = ["Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]

Prawn::Labels.generate("names.pdf", names, {:type => "Avery5160", document: { page_layout: :landscape } }) do |pdf, name|
  pdf.text name
end
```

Other document properties that can be set via this hash can be found in the [Prawn Documentation](http://prawn.majesticseacreature.com/docs/0.11.1/Prawn/Document.html#method-c-new)

## Contributors

- [Jordan Byron](http://jordanbyron.com)
- [David Speake](mailto:david@verycleverstuff.co.uk)
- [Carlo Biedenharn](mailto:cbieden@mit.edu)
- [Forrest Zeisler](https://github.com/forrest)
- [Jack Twilley](https://github.com/mathuin)
- [Ori Pekelman](https://github.com/OriPekelman)
- [Branden Gunn](https://github.com/engunneer)
