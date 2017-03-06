require 'json'
require 'pry'

module YahooGroup

  class Group

    def initialize (connection)
      @connection = connection
      @config = YAML.load_file('.config.yaml')
      @group_info = JSON.parse(connection.get("#{@config['yahoo']['api_url']}/#{@config['yahoo']['group_name']}").body)
    end

    def message_count
      last_post = @connection.get("#{@config['yahoo']['api_url']}/#{@config['yahoo']['group_name']}/messages?count=1&sortOrder=desc&direction=-1")
      totalPosts = JSON.parse(last_post.body)["ygData"]["totalRecords"]
    end

  end

end
