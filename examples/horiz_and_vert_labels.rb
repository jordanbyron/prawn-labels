require File.join(File.dirname(__FILE__), "example_helper")

class Label
  attr_reader :vertical_text

  def initialize(name, vertical_text = false)
    @name = name
    @vertical_text = vertical_text
  end
end

class Horizontal < Label
  def initialize(name)
    super(name, false)
  end

  def render(pdf)
    pdf.text "Horizontal"
    pdf.text @name
    pdf.stroke_bounds
  end
end

class Vertical < Label
  def initialize(name)
    super(name, true)
  end

  def render(pdf)
    pdf.text "Vertical"
    pdf.text @name
    pdf.stroke_bounds
  end
end

names = ["Jordan", "Chris", "Jon", "Mike"]

labels = names.map {|name| [ Horizontal.new(name), Vertical.new(name) ]}.flatten

Prawn::Labels.generate("horiz_and_vert_labels.pdf", labels, :type => "Avery5160") do |pdf, label|
  label.render(pdf)
end
