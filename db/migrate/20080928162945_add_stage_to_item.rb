class AddStageToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :stage, :string
  end

  def self.down
    remove_column :items, :stage
  end
end
