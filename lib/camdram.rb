require 'cgi'

class Camdram
  HOST = "https://www.camdram.net/"
  LOGIN_URL = HOST + "extlogin?redirect=%s"
  TOKEN_URL = HOST + "spendtoken.php?tokenid=%s"
  LOGOUT_URL = HOST + "extlogin?redirect=%s&logout=logout&extlogout=logout"
  
  RESPONSES = {
    :OK => [:status, :number, :loginname, :realname],
    :ERROR => false
  }
  
  # Camdram singleton methods:
  class << self
    
    def login_url( redirect )
      LOGIN_URL % CGI.escape(redirect)
    end
    
    def logout_url( redirect )
      LOGOUT_URL % CGI.escape(redirect)
    end
    
    def token_url( token )
      TOKEN_URL % token
    end
    
    def parse_response( response_string )
      status = response_string.lines.first.chomp.intern
      if RESPONSES[status].respond_to? :zip
        lines = response_string.chomp.split("\n", RESPONSES[status].length)
        Hash[ *RESPONSES[status].zip(lines).flatten ]
      else
        RESPONSES[status]
      end
    end
    
  end
  
end