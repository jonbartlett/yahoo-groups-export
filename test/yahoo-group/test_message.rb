require './test/test_helper'

class YahooGroupMessageTest < Minitest::Test

  FIRST_MSG_ID = 1

  def setup

    VCR.use_cassette('yahoo_login', :record => :new_episodes) do

      @config = YAML.load_file('.config.yaml')
      @username = @config["yahoo"]["username"]
      @password = @config["yahoo"]["password"]
      @connection = YahooGroup::Connection.new

      if @config["yahoo"]["group_private"] = "true"
        @connection.login(@username, @password)
      end

    end

    VCR.use_cassette('yahoo_messages', :record => :new_episodes) do

      @first_msg = YahooGroup::Message.new(@connection,FIRST_MSG_ID)

    end

  end

  def test_exists
    assert YahooGroup::Message
  end

  def test_message_class
    assert_instance_of YahooGroup::Message, @first_msg
  end

  def test_first_message
    read_message(@first_msg)
  end

  def read_message(msg)
    refute_nil msg.raw_msg
    refute_nil msg.author_name
    refute_nil msg.user_id
    refute_nil msg.profile
    refute_nil msg.from
    refute_nil msg.post_date
    refute_nil msg.topic_id
    refute_nil msg.prev_in_topic
    refute_nil msg.next_in_topic
    refute_nil msg.num_msg_in_topic
    refute_nil msg.subject
    refute_nil msg.raw_email
#    refute_nil msg.email_body
#    assert_instance_of Mail::Message, msg.email
  end

end
