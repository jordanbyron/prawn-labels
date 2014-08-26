require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/spec'
require 'purdytest'

require 'prawn'
require_relative '../lib/prawn/labels'

class MiniTest::Spec
  after do
    if ENV['DEBUG']
      `open #{pdf_path}`
    end
  end
end
