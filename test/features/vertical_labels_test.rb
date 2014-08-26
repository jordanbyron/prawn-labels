require_relative '../test_helper'

describe "Vertical test" do
  let(:pdf_path) { "test/pdfs/vertical_labels.pdf" }

  before { FileUtils.rm(pdf_path, :force => true) }

  it "can be set for the whole document via type" do
    names  = ["Jordan", "Chris", "Jon", "Mike"]

    Prawn::Labels.types["Avery5160"]["vertical_text"] = true

    Prawn::Labels.generate(pdf_path, names,
                           :type => "Avery5160") do |pdf, name|
      pdf.text name
    end

    File.exists?(pdf_path).must_equal true
  end
end
