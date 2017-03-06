require './test/test_helper'

class YahooGroupGroupTest < Minitest::Test

  def setup

    VCR.use_cassette('yahoo_login', :record => :new_episodes) do

      @connection = YahooGroup::Connection.new
      @group = YahooGroup::Group.new(@connection)

    end

  end

  def test_exists
    assert YahooGroup::Group
  end

  def test_group_class
    assert_instance_of YahooGroup::Group, @group
  end

  def test_fetched_message_count
    VCR.use_cassette('yahoo_message_count', :record => :new_episodes) do
      refute_nil @group.message_count
    end
  end

end

