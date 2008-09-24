class SessionController < ApplicationController
  
  def login
  end
  
  def new
    if @user
      redirect_to root_path
    else
      session[:return] = params[:return]
      redirect_to Camdram.login_url(create_session_url)
    end
  end
  
  def create
    if params[:camdramauthtoken]
      if result = spend_token( params[:camdramauthtoken] )
        user = User.find_or_create_by_camdram_result(result)
        session[:user_id] = user.id
        redirect_to (session[:return] || root_url)
      else
        flash[:error] = "System error: error or unknown response from Camdram. Cannot log in."
        redirect_to root_url
      end
    else
      flash[:error] = "System error: no 'camdramauthtoken' given. Cannot log in."
      redirect_to root_url
    end
  end
  
  def destroy
    session[:user_id] = nil
    session[:return] = nil
    redirect_to Camdram.logout_url(root_url)
  end
  
  private
  
  def spend_token( token )
    require 'uri'
    require 'net/http'
    require 'net/https'
    
    uri = URI.parse( Camdram.token_url(token) )
    
    req = Net::HTTP.new(uri.host, uri.port)
    req.use_ssl = true
    resp = req.get(uri.request_uri)
    
    Camdram.parse_response(resp.body)
  end
    
end
