require './test/test_helper'

class YahooGroupConnectionTest < Minitest::Test

  def setup
      VCR.use_cassette('yahoo_login', :record => :new_episodes) do
        @connection = YahooGroup::Connection.new
      end
  end

  def test_exists
    assert YahooGroup::Connection
  end

  def test_connection_class
    assert_instance_of YahooGroup::Connection, @connection
  end

end

