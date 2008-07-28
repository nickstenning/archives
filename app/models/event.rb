class Event < ActiveRecord::Base
  
  belongs_to :show
  belongs_to :venue
  
  validates_date_time :start, :message => "is not a valid date/time",
                      :before => :end, 
                      :before_message => "must be before the event end time"
  validates_date_time :end, :message => "is not a valid date/time"
  
end
