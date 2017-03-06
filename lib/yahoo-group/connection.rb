require 'mechanize'
require 'yaml'

module YahooGroup

  class Connection < Mechanize

    def initialize
      super

      config = YAML.load_file('.config.yaml')

      if config["yahoo"]["group_private"] = "true"
        login(config["yahoo"]["username"], config["yahoo"]["password"])
      end

    end

    def login(username, password)
      login_page = self.get('https://login.yahoo.com')
      login_form = login_page.forms.first
      login_form['username'] = username
      login_form['passwd'] = password
      login_page = login_form.submit
    end

  end

end
