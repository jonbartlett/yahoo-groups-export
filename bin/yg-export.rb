require './lib/yahoo-group'

require 'yaml'
require 'mongo'

config = YAML.load_file('.config.yaml')

client = Mongo::Client.new([ '127.0.0.1:27017'], :database => 'syncro')
db = client.database

collection = client[:posts]
missing_collection = client[:missing_posts]

connection = YahooGroup::Connection.new
group = YahooGroup::Group.new(connection)

total_record_count = group.message_count
puts total_record_count
config['exporter']['total_record_count'] = total_record_count

if config['exporter']['last_record_exported'].nil?
  current_record = 1
else
  current_record = config['exporter']['last_record_exported'] + 1
end

if total_record_count > 0

  while current_record <= total_record_count
    begin

      puts "record#: #{current_record}"

      begin

        msg = YahooGroup::Message.new(connection, current_record)
        result = collection.insert_one(msg.raw_msg)
        puts result

      rescue Mechanize::ResponseCodeError # Net::HTTPNotFound

        doc = { id: "#{current_record}", exception: "#{$!}" }
        missing_collection.insert_one(doc)
        puts "#{$!}"

      end

      config['exporter']['last_record_exported'] = current_record

      current_record += 1

    rescue Exception => error

      puts error
      break

    end

  end

end


File.open(".config.yaml", "r+") do |f|
  f.write(config.to_yaml)
end



