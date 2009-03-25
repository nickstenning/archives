class AddItemType < ActiveRecord::Migration
  def self.up
    create_table :item_types do |t|
      t.string :name
      t.timestamps
    end
    
    change_table :items do |t|
      t.references :item_type
    end
    
    %w(Flyer Poster Correspondence Accounts Minutes).each do |n|
      ItemType.create(:name => n)
    end
  end

  def self.down
    remove_column :items, :item_type_id
    drop_table :item_types
  end
end
