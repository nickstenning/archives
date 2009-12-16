class ShowsController < ApplicationController
  
  def index
    if params[:q]
      @shows = Show.find(:all, :conditions => ["name LIKE ?", "%#{params[:q]}%"])
    else
      @shows = Show.paginate :page => params[:page]
    end
    
    respond_to do |wants|
      wants.text { render :text => @shows.map(&:name).join("\n") }
      wants.json do
        showlist = @shows.map do |s|
          {:id => s.id, :name => s.name}.to_json
        end
        render :text => showlist.join("\n")
      end
      wants.html
    end
  end
end

