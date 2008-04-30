class Person < ActiveRecord::Base

  has_many :organisation_roles
  has_many :organisations, :through => :organisation_roles
  
  has_many :show_roles
  has_many :shows, :through => :show_roles
    
  has_many :item_linkings, :as => :item_linkable, :dependent => :destroy
  has_many :items, :through => :item_linkings

end
