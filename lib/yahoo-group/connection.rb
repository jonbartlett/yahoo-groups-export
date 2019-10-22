require 'mechanize'
require 'yaml'

module YahooGroup

  class Connection < Mechanize

    def initialize
      super

      self.user_agent_alias = 'Mac Safari'

      config = YAML.load_file('.config.yaml')

      if config["yahoo"]["group_private"] = "true"
        login(config["yahoo"]["username"], config["yahoo"]["password"])
      end

    end

    def login(username, password)

      login_page = self.get('https://login.yahoo.com')
      login_form = login_page.forms.first
      login_form['username'] = username
      sleep 2
      next_page = login_form.submit

      next_form = next_page.forms.first
      next_form['password'] = password
      verify_button = next_form.buttons_with(:name => 'verifyPassword').first
      sleep 2
      logged_in_page = self.submit(next_form, verify_button)

      if (next1_page.links_with(:text => 'Sign up').empty?)
        raise 'Could not log in.....'
      end if

      puts 'Logged in....'

    end

  end

end
