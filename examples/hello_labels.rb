require File.join(File.dirname(__FILE__), "example_helper")

oneline =    "1"
twoline =    "2\n2"
threeline =  (["3"]*3).join("\n")
fourline =   (["4"]*4).join("\n")
fiveline =   (["5"]*5).join("\n")
sixline =    (["6"]*6).join("\n") 
sevenline =  (["7"]*7).join("\n")
eightline =  (["8"]*8).join("\n") 
nineline =   (["9"]*9).join("\n")
tenline =    (["10"]*10).join("\n") 
longline =   "this\nis\nthelonglined\nentrywhereijusttypealottomakeitoverflowthebuffer\nandthislinetriggersbutitdontkeep"
longline2 =   "this\nis not\nthe other long line\nentry where i just type to make it over flow the buffer\nlol"
wtf = (["50"]*50).join("\n")

fancy_names = [oneline, twoline, threeline,
               fourline, fiveline, sixline,
               sevenline, eightline, nineline,
               tenline, "Mike", "Kelly",
               "Bob", "Greg", "Jordan", 
               "Chris", "Jon", "Mike",
               "Kelly", longline, longline2,
               "Jordan", "Chris", "Jon",
                wtf, "Kelly", "Bob",
               "Greg", "Jordan", "Chris",
              
               "Jon", "Mike", "Kelly",
               "Bob", "Greg"]


Prawn::Labels.generate("hello_labels.pdf", fancy_names, :type => "Avery5160") do |pdf, name|
  pdf.text name
end

