class AddDraftToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :draft, :boolean
  end

  def self.down
    remove_column :items, :draft
  end
end
