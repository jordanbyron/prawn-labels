# Prawn/Labels: Label generator for Prawn PDFs

Prawn/Labels takes the guess work out of generating labels using Prawn

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

### Generating labels in a Rails controller

```ruby
class LabelsController < ApplicationController
  def fancy_labels
    names = ["Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]
  
    labels = Prawn::Labels.render(names, :type => "Avery5160") do |pdf, name|
      pdf.text name
    end

    send_data labels, :filename => "names.pdf", :type => "application/pdf"
  end
end
```

Notice here we use the `render` method rather than `generate`.

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

Prawn::Labels.generate("names.pdf", names, type: "Avery5160", document: { page_layout: :landscape }) do |pdf, name|
  pdf.text name
end
```

Other document properties that can be set via this hash can be found in the [Prawn Documentation](http://prawnpdf.org/docs/0.11.1/Prawn/Document.html#method-c-new)

## Contributing

**Developers, developers, developers!!**

Contributors retain copyright to their work but must agree to release their
contributions under the same terms as this project. For details, please see the
LICENSE file.

If you would like to help with developing Prawn/Labels, please get in touch!
Contact Jordan through [GitHub (@jordanbyron)][gh],
[Twitter (@jordan_byron)][twitter] or open up a [ticket][gh-issues].

### Submitting a Pull Request - We :heart: pull requests!

1. If an issue doesn't exist for your bug or feature create one on 
   [GitHub Issues][gh-issues].
    - Don't be afraid to get feedback on your idea before you begin
      development work. In fact it is encouraged. I promise I don't bite
      :wink:
2. Fork the repo and copy it down to your local machine.
3. Run `bundle install` in the root directory to install all of the
    dependencies.
4. Create a topic branch (e.g. `prawn-2-support`).
5. Implement your feature or bug fix.
6. Add documentation for your feature or bug fix.
7. Add tests for your feature or bug fix.
8. Run `ruby test/suite.rb`. If your changes are not covered, go back to step 6.
9. If your change affects something in this `README`, please update it.
10. Commit and push your changes.
11. Submit a pull request.

[gh-issues]: https://github.com/jordanbyron/prawn-labels/issues
[gh]: https://github.com/jordanbyron
[twitter]: http://twitter.com/jordan_byron

__Note about our test suite__: It kinda stinks :poop: At the moment the tests
just do a quick "Does this code run without raising any errors and at the end
does it generate the PDF we expect it to generate" check. Eventually I'd like to
add more robust tests, but at this point they are better than no tests! So
please keep that in mind when you add your tests or run the whole suite.

To see what the test PDFs look like you can append `DEBUG=true` to your test run
and all generated PDFs will be opened for visual debugging :thumbsup:

### Contributors

- [Jordan Byron](http://jordanbyron.com)
- [David Speake](mailto:david@verycleverstuff.co.uk)
- [Carlo Biedenharn](mailto:cbieden@mit.edu)
- [Forrest Zeisler](https://github.com/forrest)
- [Jack Twilley](https://github.com/mathuin)
- [Ori Pekelman](https://github.com/OriPekelman)
- [Branden Gunn](https://github.com/engunneer)
