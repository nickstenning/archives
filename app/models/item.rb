class Item < ActiveRecord::Base
  
  # Set up our end of a polymorphic association. Many types of object can have
  # item_linkings. In our case, Show, Person, etc.
  has_many :item_linkings
  
  # Abstraction for our on-disk-or-elsewhere scanned file objects.
  has_many :item_files
  
  validates_presence_of :name, :message => "can't be blank"

end
