# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '82894eb6e2af7f60a530b276943881a3'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  # Protect the staging instance with people's subversion usernames/passwords.
  # This points to the mod_dav_svn password file on romeo.
  if Rails.env == "staging"
    htpasswd :realm => "ADC Rails Staging Area", :file => "/etc/apache2/dav_svn.passwd"
  end
    
  def get_user
    @user = User.find_by_id(session[:user_id])
  end 

  def login_required
    unless @user
      flash[:error] = "Please log in before attempting to use this feature."
      redirect_to login_path(:return => request.request_uri) 
    end
  end
  
  before_filter :get_user
  
end
