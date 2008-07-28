class ShowRole < ActiveRecord::Base
  
  belongs_to :show
  belongs_to :person
  
  validates_presence_of :name, :message => "can't be blank"
  
end
