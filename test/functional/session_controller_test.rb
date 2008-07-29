require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  
  JANE_TOKEN = "123thisIsATestTokenForJane"
  JOHN_TOKEN = "456thisIsATestTokenForJohn"
  FAKE_TOKEN = "MwahahaHax0rs"
  
  def setup
    FakeWeb.register_uri(Camdram.token_url(JANE_TOKEN), :string => "OK\n1234\njor123\nJane O'Reilly from Camdram\n")
    FakeWeb.register_uri(Camdram.token_url(JOHN_TOKEN), :string => "OK\n5678\njxd456\n\n")
    FakeWeb.register_uri(Camdram.token_url(FAKE_TOKEN), :string => "ERROR\n")
  end
  
  def assert_logged_in( user )
    assert_equal user.id, session[:user_id]
  end
  
  def assert_logged_out
    assert_nil session[:user_id]
  end
  
  def test_new_session_sends_to_camdram
    get :new
    assert_redirected_to Camdram.login_url( create_session_url )
  end
  
  def test_getback_from_camdram_logs_in
    post :create, :camdramauthtoken => JANE_TOKEN
    assert_redirected_to root_url
    assert_logged_in users(:jane)
  end
  
  def test_getback_from_camdram_deals_with_empty_attributes
    post :create, :camdramauthtoken => JOHN_TOKEN
    assert_redirected_to root_url
    assert_logged_in users(:john)
  end
  
  def test_return_url_remembered_across_redirects
    get :new, :return => "http://test_my_redirects_baby"
    post :create, :camdramauthtoken => JANE_TOKEN
    assert_redirected_to "http://test_my_redirects_baby"
  end
  
  def test_destroy_session_sends_to_camdram
    get :destroy
    assert_redirected_to Camdram.logout_url( root_url )
  end
  
  def test_destroy_session_empties_session_keys
    get :new, :return => "http://test_my_redirects_baby"
    post :create, :camdramauthtoken => JANE_TOKEN
    get :destroy
    assert_logged_out
    assert_nil session[:return]
  end
  
  def test_wont_create_without_token
    post :create
    assert_redirected_to root_url
    assert_equal "System error: no 'camdramauthtoken' given. Cannot log in.", flash[:error]
  end
  
  def test_wont_login_with_invalid_response_from_camdram
    post :create, :camdramauthtoken => FAKE_TOKEN
    assert_redirected_to root_url
    assert_logged_out
    assert_equal "System error: error or unknown response from Camdram. Cannot log in.", flash[:error]
  end

end
