class Organisation < ActiveRecord::Base
  
  has_many :organisation_roles
  has_many :people, :through => :organisation_roles
  
  has_and_belongs_to_many :shows
  
  # Polymorphic association with Items.
  has_many :item_linkings, :as => :item_linkable, :dependent => :destroy
  has_many :items, :through => :item_linkings
  
end
