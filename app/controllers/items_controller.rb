class ItemsController < ApplicationController
  
  before_filter :login_required

  def form
    render :template => "items/form/#{params[:stage]}", :layout => false
  end
  
end
