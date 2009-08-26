require File.dirname(__FILE__) + '/../spec_helper'

describe SessionController do
  fixtures :users
  
  JANE_TOKEN = "123thisIsATestTokenForJane"
  JOHN_TOKEN = "456thisIsATestTokenForJohn"
  FAKE_TOKEN = "MwahahaHax0rs"
  
  before do
    FakeWeb.register_uri(Camdram.token_url(JANE_TOKEN), :string => "OK\n1234\njor123\nJane O'Reilly from Camdram\n")
    FakeWeb.register_uri(Camdram.token_url(JOHN_TOKEN), :string => "OK\n5678\njxd456\n\n")
    FakeWeb.register_uri(Camdram.token_url(FAKE_TOKEN), :string => "ERROR\n")
  end
  
  def assert_logged_in( user )
    session[:user_id].should == user.id
  end
  
  def assert_logged_out
    session[:user_id].should == nil
  end
  
  it "new session sends to camdram" do
    get :new
    assert_redirected_to Camdram.login_url( create_session_url )
  end
  
  it "getback from camdram logs in" do
    post :create, :camdramauthtoken => JANE_TOKEN
    assert_redirected_to root_url
    assert_logged_in users(:jane)
  end
  
  it "getback from camdram deals with empty attributes" do
    post :create, :camdramauthtoken => JOHN_TOKEN
    assert_redirected_to root_url
    assert_logged_in users(:john)
  end
  
  it "return url remembered across redirects" do
    get :new, :return => "http://test_my_redirects_baby"
    post :create, :camdramauthtoken => JANE_TOKEN
    assert_redirected_to "http://test_my_redirects_baby"
  end
  
  it "destroy session sends to camdram" do
    get :destroy
    assert_redirected_to Camdram.logout_url( root_url )
  end
  
  it "destroy session empties session keys" do
    get :new, :return => "http://test_my_redirects_baby"
    post :create, :camdramauthtoken => JANE_TOKEN
    get :destroy
    assert_logged_out
    session[:return].should == nil
  end
  
  it "wont create without token" do
    post :create
    assert_redirected_to root_url
    flash[:error].should == "System error: no 'camdramauthtoken' given. Cannot log in."
  end
  
  it "wont login with invalid response from camdram" do
    post :create, :camdramauthtoken => FAKE_TOKEN
    assert_redirected_to root_url
    assert_logged_out
    flash[:error].should == "System error: error or unknown response from Camdram. Cannot log in."
  end

end
