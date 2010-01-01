class RenameItemLinkingToLinkedObject < ActiveRecord::Migration
  def self.up
    rename_column :item_linkings, :item_linking_id, :linked_object_id
    rename_column :item_linkings, :item_linking_type, :linked_object_type
  end

  def self.down
    rename_column :item_linkings, :linked_object_id, :item_linking_id
    rename_column :item_linkings, :linked_object_type, :item_linking_type
  end
end
