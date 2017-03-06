require 'json'
require 'pry'
require 'mail'

module YahooGroup

  class Message

    attr_reader :msg_id, :raw_msg, :author_name, :user_id, :profile, :from
    attr_reader :post_date, :topic_id, :prev_in_topic, :next_in_topic, :num_msg_in_topic  
    attr_reader :subject, :raw_email

    def initialize (connection, msg_id)

      @config = YAML.load_file('.config.yaml')
      @msg_id = msg_id
      @raw_page = connection.get("#{@config['yahoo']['api_url']}/#{@config['yahoo']['group_name']}/messages/#{msg_id}/raw")

      if @raw_page.code == "200"

        @raw_msg          = JSON.parse(@raw_page.body)
        @author_name      = @raw_msg["ygData"]["authorName"]
        @user_id          = @raw_msg["ygData"]["userId"]
        @profile          = @raw_msg["ygData"]["profile"]
        @from             = @raw_msg["ygData"]["from"]
        @post_date        = @raw_msg["ygData"]["postDate"]
        @topic_id         = @raw_msg["ygData"]["topicId"]
        @prev_in_topic    = @raw_msg["ygData"]["prevInTopic"]
        @next_in_topic    = @raw_msg["ygData"]["nextInTopic"]
        @num_msg_in_topic = @raw_msg["ygData"]["numMessagesInTopic"]
        @subject          = @raw_msg["ygData"]["subject"]
        @raw_email        = @raw_msg["ygData"]["rawEmail"]
        #@email            = Mail.new(@raw_email)

        #binding.pry if @msg_id == 18

        #if @email.multipart?

          #@email.body.split!('9nlWnTS9ocNmxdhsK3FKVLWiM6a5jwOaA8HvrLV')
          #@email_body = @email.parts[0].decoded

        #else

         #@email_body = @email.decoded

      # end
#        binding.pry

#        @email.body.split!('9nlWnTS9ocNmxdhsK3FKVLWiM6a5jwOaA8HvrLV')
      else
        raise

      end

    end

  end

end

