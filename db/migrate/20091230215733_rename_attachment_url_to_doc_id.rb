class RenameAttachmentUrlToDocId < ActiveRecord::Migration
  def self.up
    rename_column :attachments, :url, :doc_id
  end

  def self.down
    rename_column :attachments, :doc_id, :url
  end
end
