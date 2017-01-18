require 'mechanize'
require 'json'
require 'pry'
require 'mail'

mechanize = Mechanize.new

page = mechanize.get('https://login.yahoo.com')

form = page.forms.first

form['username'] = ''
form['passwd'] = ''

page = form.submit

# Get last message to determine max message id (message count)
last_post = mechanize.get('https://groups.yahoo.com/api/v1/groups/Syncro_T3_Australia/messages?count=1&sortOrder=desc&direction=-1')

totalPosts = JSON.parse(last_post.body)["ygData"]["totalRecords"]

if totalPosts > 0



end if

# multi-part base64 encoded
#raw_msg = mechanize.get('https://groups.yahoo.com/api/v1/groups/Syncro_T3_Australia/messages/26738/raw')

# single-part base64 encoded
# raw_msg = mechanize.get('https://groups.yahoo.com/api/v1/groups/Syncro_T3_Australia/messages/26736/raw')

#
#raw_msg = mechanize.get('https://groups.yahoo.com/api/v1/groups/Syncro_T3_Australia/messages/1/raw')

raw_msg = mechanize.get('https://groups.yahoo.com/api/v1/groups/Syncro_T3_Australia/messages/26739/raw')


msg_json = JSON.parse(raw_msg.body)

email = Mail.new(msg_json["ygData"]["rawEmail"])

binding.pry

email.body.split!('9nlWnTS9ocNmxdhsK3FKVLWiM6a5jwOaA8HvrLV')

if email.body.multipart?

 puts email.body.parts[0].decoded

else

 puts email.body.decoded

end if


binding.pry


