class PeopleController < ApplicationController
  def index
    if params[:q]
      @people = Person.find(:all, :conditions => ["name LIKE ?", "%#{params[:q]}%"])
    else
      @people = Person.paginate :page => params[:page]
    end
    
    respond_to do |wants|
      wants.text { render :text => @people.map(&:name).join("\n") }
      wants.html
    end
  end
end
