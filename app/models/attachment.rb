require 'pathname'

class Attachment < ActiveRecord::Base

  belongs_to :item

  validates_presence_of :doc_id, :message => "can't be blank"

  named_scope :unattached, :conditions => "item_id = '' or item_id is null"

end
