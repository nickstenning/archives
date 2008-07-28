class ItemFile < ActiveRecord::Base
  
  belongs_to :item
  
  validates_presence_of :url, :message => "can't be blank"

end
