require 'pathname'

class Attachment < ActiveRecord::Base

  belongs_to :item

  validates_presence_of :doc_id, :message => "can't be blank"
  validates_uniqueness_of :doc_id, :message => "must be unique"

  named_scope :unattached, :conditions => "item_id = '' or item_id is null"
  
  def original_path
    File.join(folder, "#{doc_id}.tif")
  end
  
  def pdf_path
    File.join(folder, "#{doc_id}.pdf")
  end
  
  def thumbnail_path
    File.join(folder, "#{doc_id}_H100.png")
  end
  
  def public_thumbnail_path
    File.join(public_folder, "#{doc_id}_H100.png")
  end
  
  protected
  
  def folder
    File.join(AppConfig.archives_path, doc_id)
  end
  
  def public_folder
    File.join(AppConfig.archives_public_path, doc_id)
  end
  
end
