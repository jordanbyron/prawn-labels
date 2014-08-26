require_relative '../test_helper'

describe "Shrink content" do
  let(:pdf_path) { "test/pdfs/shrink_to_fit.pdf" }

  before { FileUtils.rm(pdf_path, :force => true) }

  it "fits content to cells" do
    one   = "1"
    two   = "2\n2"
    three = (["3"]*3).join("\n")
    four  = (["4"]*4).join("\n")
    five  = (["5"]*5).join("\n")
    six   = (["6"]*6).join("\n")
    seven = (["7"]*7).join("\n")
    eight = (["8"]*8).join("\n")
    nine  = (["9"]*9).join("\n")
    ten   = (["10"]*10).join("\n")
    long  = %{this
              is
              thelonglined
              entrywhereijusttypealottomakeitoverflowthebuffer
              andthislinetriggersbutitdontkeep }
    long2 = %{this
              is just
              the other long line
              entry where i just type to make it over flow the buffer
              lol }
    fifty = (["50"]*50).join("\n")

    test_names = [one, two, three, four, five, six, seven, eight, nine, ten,
                  "Mike", "Kelly", "Bob", "Greg", "Jordan",  "Chris", "Jon", "Mike",
                  "Kelly", long, long2, "Jordan", "Chris", "Jon", fifty, "Kelly",
                  "Bob", "Greg", "Jordan", "Chris",
                  #these next five should be on the next page.
                  "Jon", "Mike", "Kelly", "Bob", "Greg"]

    Prawn::Labels.generate(pdf_path, test_names, :type => "Avery5160", :shrink_to_fit => true) do |pdf, name|
      pdf.text name
    end

    File.exists?(pdf_path).must_equal true
  end
end
