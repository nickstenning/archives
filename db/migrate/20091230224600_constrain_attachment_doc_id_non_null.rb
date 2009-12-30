class ConstrainAttachmentDocIdNonNull < ActiveRecord::Migration
  def self.up
    change_column :attachments, :doc_id, :string, :null => false
    add_index :attachments, :doc_id, :unique => true 
  end

  def self.down
    remove_index :attachments, :doc_id
    change_column :attachments, :doc_id, :string, :null => true
  end
end
