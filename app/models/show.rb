class Show < ActiveRecord::Base
  
  has_many :show_roles
  has_many :people, :through => :show_roles
  
  has_and_belongs_to_many :organisations
  
  # Show has_many Events. An Event has_one Venue.
  has_many :events
  # So, let's have some syntactic sugar, and let a Show appear to have_many
  # Venues through those on its Events. Make sense?
  has_many :venues, :through => :events
  
  has_many :item_linkings, :as => :item_linkable, :dependent => :destroy
  has_many :items, :through => :item_linkings
  
end
