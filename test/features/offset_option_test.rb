require_relative '../test_helper'

describe "Offset test 1" do
  let(:pdf_path) { "test/pdfs/offset_option.pdf" }

  before { FileUtils.rm(pdf_path, :force => true) }

  it "raises an error if used with vertical_text" do
    names  = ["Jordan", "Chris", "Jon", "Mike"]

    assert_raises(RuntimeError) do
      Prawn::Labels.generate(pdf_path, names,type: "Avery5160", vertical_text: true , offset: [10,10]) do |pdf, name|
        pdf.text name
      end
    end
  end
  
  it "raises an error if used with shrink_to_fit" do
    names  = ["Jordan", "Chris", "Jon", "Mike"]

    assert_raises(RuntimeError) do
      Prawn::Labels.generate(pdf_path, names,type: "Avery5160", shrink_to_fit: true , offset: [10,10]) do |pdf, name|
        pdf.text name
      end
    end
  end
end

describe "Offset test 2" do
  let(:pdf_path) { "test/pdfs/offset_option.pdf" }

  before { FileUtils.rm(pdf_path, :force => true) }

  
  it "writes an output file if used without shrink_to_fit and vertaival_text" do
    names  = ["Jordan", "Chris", "Jon", "Mike"]

    Prawn::Labels.generate(pdf_path, names,type: "Avery5160",  offset: [30,30]) do |pdf, name|
      pdf.text name
    end

    File.exists?(pdf_path).must_equal true    
    
  end
  
end
