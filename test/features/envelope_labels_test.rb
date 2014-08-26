require_relative '../test_helper'

describe "Envelopes" do
  let(:pdf_path) { "test/pdfs/envelope_labels.pdf" }

  before { FileUtils.rm(pdf_path, :force => true) }

  it "wraps long text" do
    fancy_names = ["Jordan With a long address\n that goes over multiple " +
                   "lines blah blah blah",
                   "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]

    Prawn::Labels.generate(pdf_path, fancy_names,
                           :type => "Envelope10") do |pdf, name|
      pdf.text name
    end

    File.exists?(pdf_path).must_equal true
  end
end
