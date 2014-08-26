test_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(test_root + '/features/*.rb') {|f| require f }
