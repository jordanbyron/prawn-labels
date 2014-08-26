require_relative '../test_helper'

describe "Custom Labels" do
  let(:pdf_path) { "test/pdfs/custom_labels.pdf" }
  let(:names)    { 5.times.map {
    ["Jordan", "Chris", "Jon", "Mike", "Kelly", "Bob", "Greg"]
  }.flatten}

  before { FileUtils.rm(pdf_path, :force => true) }

  it "can be set via a hash" do
    #define a custom label type
    Prawn::Labels.types = {
      "Agipa119461" => {
        "paper_size"    => "A4",
        "top_margin"    => 36.57,
        "bottom_margin" => 0,
        "left_margin"   => 20.551,
        "right_margin"  => 20.551,
        "columns"       => 3,
        "rows"          => 8,
        "column_gutter" => 7.087,
        "row_gutter"    => 0
    }}

    Prawn::Labels.generate(pdf_path, names, :type => "Agipa119461") do |pdf, name|
      pdf.text name
    end

    File.exists?(pdf_path).must_equal true
  end

  it "can be set via a custom YAML file" do
    #use a configuration file for custom labels
    Prawn::Labels.types = File.join(File.dirname(__FILE__),
                                    "../types/custom_label.yml")

    Prawn::Labels.generate(pdf_path, names, :type => "quartersheet") do |pdf, name|
      pdf.text name
    end

    File.exists?(pdf_path).must_equal true
  end
end
