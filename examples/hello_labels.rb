require File.join(File.dirname(__FILE__), "example_helper")

Prawn::Labels.generate("hello_labels.pdf", :type => "Avery5160") do |pdf,cell|
  pdf.text cell.name
  pdf.stroke do
    pdf.rectangle(pdf.bounds.top_left, cell.width, cell.height)
  end
end