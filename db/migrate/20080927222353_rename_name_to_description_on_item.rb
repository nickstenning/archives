class RenameNameToDescriptionOnItem < ActiveRecord::Migration
  def self.up
    rename_column :items, :name, :description
  end

  def self.down
    rename_column :items, :description, :name
  end
end
