require File.join(File.dirname(__FILE__), "example_helper")

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
long  = "this\nis\nthelonglined\nentrywhereijusttypealottomakeitoverflowthebuffer\nandthislinetriggersbutitdontkeep"
long2 = "this\nis just\nthe other long line\nentry where i just type to make it over flow the buffer\nlol"
fifty = (["50"]*50).join("\n")

test_names = [one, two, three,
              four, five, six,
              seven, eight, nine,
              ten, "Mike", "Kelly",
              "Bob", "Greg", "Jordan", 
              "Chris", "Jon", "Mike",
              "Kelly", long, long2,
              "Jordan", "Chris", "Jon",
               fifty, "Kelly", "Bob",
              "Greg", "Jordan", "Chris",
#these next five should be on the next page.
              "Jon", "Mike", "Kelly",
              "Bob", "Greg"]


Prawn::Labels.generate("test_labels.pdf", test_names, :type => "Avery5160", :shrink_to_fit => true) do |pdf, name|
  pdf.text name
end

