require "open-uri"
require_relative '../test_helper'

describe "Images" do
  let(:pdf_path) { "test/pdfs/image_labels.pdf" }

  before { FileUtils.rm(pdf_path, :force => true) }

  it "can be used inside cells" do
    fancy_names = ["Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
                   "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
                   "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
                   "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg",
                   "Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]

    Prawn::Labels.generate(pdf_path, fancy_names,
                           :type => "Avery5160") do |pdf, name|
      pdf.text name
      pdf.image open("http://jordanbyron.com/me.png")
    end

    File.exists?(pdf_path).must_equal true
  end
end
