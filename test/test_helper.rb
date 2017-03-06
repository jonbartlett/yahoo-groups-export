require './lib/yahoo-group'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'yaml'
require 'mail'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
end
