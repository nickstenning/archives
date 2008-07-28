class Event < ActiveRecord::Base
  
  belongs_to :show
  belongs_to :venue
  
end
