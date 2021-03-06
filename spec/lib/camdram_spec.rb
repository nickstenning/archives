require File.dirname(__FILE__) + '/../spec_helper'

# TODO: convert these to proper BDD-style assertions.

describe Camdram do
  def test_login_url
    assert_equal "https://www.camdram.net/extlogin?redirect=http%3A%2F%2Ftesturl%2F", Camdram.login_url("http://testurl/")
  end
  
  def test_logout_url
    assert_equal "https://www.camdram.net/extlogin?redirect=http%3A%2F%2Ftesturl%2F&logout=logout&extlogout=logout", Camdram.logout_url("http://testurl/")
  end
  
  def test_token_url
    assert_equal "https://www.camdram.net/spendtoken.php?tokenid=7cf9e5d6eb396e0ac6f905cb0bdce2b8", Camdram.token_url("7cf9e5d6eb396e0ac6f905cb0bdce2b8")
  end
  
  def test_parse_response_simple
    expected = { :status => "OK", :number => "1234", :loginname => "abc789", :realname => "Marco Polo" }
    assert_equal expected, Camdram.parse_response("OK\n1234\nabc789\nMarco Polo\n")
  end
  
  def test_parse_response_missing_attributes
    expected = { :status => "OK", :number => "1234", :loginname => "abc789", :realname => "" }
    assert_equal expected, Camdram.parse_response("OK\n1234\nabc789\n\n")
    expected = { :status => "OK", :number => "1234", :loginname => "", :realname => "Marco Polo" }
    assert_equal expected, Camdram.parse_response("OK\n1234\n\nMarco Polo\n")
  end
  
  def test_parse_response_error
    assert_equal false, Camdram.parse_response("ERROR\n")
  end
  
  def test_parse_response_unknown
    assert_nil Camdram.parse_response("UnlikelyToRecognizeThis\nMonkeynuts\n")
  end
end