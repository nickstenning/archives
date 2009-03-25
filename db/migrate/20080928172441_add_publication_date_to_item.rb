class AddPublicationDateToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :publication_date, :date
    add_column :items, :publication_date_precision, :string, :default => "day"
  end

  def self.down
    remove_column :items, :publication_date_precision
    remove_column :items, :publication_date
  end
end
