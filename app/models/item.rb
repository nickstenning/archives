class Item < ActiveRecord::Base
  
  # Set up our end of a polymorphic association. Many types of object can have
  # item_linkings. In our case, Show, Person, etc.
  has_many :item_linkings
  
  # Abstraction for our on-disk-or-elsewhere scanned file objects.
  has_many :attachments
  
  # Classification of items. (e.g. Flyer, Poster, Correspondence, etc.)
  belongs_to :item_type
  
  validates_presence_of :description, :message => "can't be blank", :if => proc { |i| i.stage == 'description' }
  
  %w[show person organisation].each do |obj|
    define_method(obj.pluralize) do
      Object.const_get(obj.classify).find(:all, :joins => :item_linkings, :conditions => ['item_linkings.item_id = ?', id])
    end
  end

end
