require 'md5'

class Show < ActiveRecord::Base
  
  has_many :show_roles
  has_many :people, :through => :show_roles
  
  has_and_belongs_to_many :organisations
  
  # Show has_many Events. An Event has_one Venue.
  has_many :events
  # So, let's have some syntactic sugar, and let a Show appear to have_many
  # Venues through those on its Events. Make sense?
  has_many :venues, :through => :events
  
  has_many :item_linkings, :as => :item_linking, :dependent => :destroy
  has_many :items, :through => :item_linkings
  
  validates_presence_of :name, :message => "can't be blank"
  
  # TODO: do something more sensible than this!
  # We want to extract a thumbnail from the show's items.
  def thumbnail_url
    hash = MD5.hexdigest(name)
    "http://www.gravatar.com/avatar/#{hash}?s=50&r=any&default=monsterid&forcedefault=1"
  end
end
