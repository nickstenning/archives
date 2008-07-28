class Venue < ActiveRecord::Base
  
  has_many :events
  
  validates_presence_of :name, :message => "can't be blank"
  
end
