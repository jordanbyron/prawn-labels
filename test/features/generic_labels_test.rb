require_relative '../test_helper'

describe "Generic" do
  let(:pdf_path) { "test/pdfs/generic_labels.pdf" }

  before { FileUtils.rm(pdf_path, :force => true) }

  it "can make some labels" do
    fancy_names = ["Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
                   "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
                   "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
                   "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
                   "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]

    Prawn::Labels.generate(pdf_path, fancy_names,
                           :type => "Avery5160") do |pdf, name|
      pdf.text name
    end

    File.exists?(pdf_path).must_equal true
  end
end
