class ShowsController < ApplicationController
  
  def index
    if params[:q]
      @shows = Show.find(:all, :conditions => ["name LIKE ?", "%#{params[:q]}%"])
    end
    
    respond_to do |wants|
      wants.text { render :text => @shows.map(&:name).join("\n") }
    end
  end
end
