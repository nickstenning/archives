class InitialMigration < ActiveRecord::Migration
  def self.up
    
    # Create tables for first-class domain objects.
    #
    # t.timestamps is syntactic sugar and gives us created_at and updated_at, 
    # "magic" columns that are handled internally by ActiveRecord.
    #
    # t.references is a nomenclature abstraction that gives us a suitably named
    # foreignkey_id column. So, for example:
    # 
    #   t.references :monkey
    #
    # will give a 'monkey_id' column, where :monkey represents our Monkey model.
    #
    # -NS 2008-04-28
    
    create_table :items do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
    
    #
    # Item <- (Objects) polymorphic link table. This is indexed on *both*
    # item_linking_id and item_linking_type. See models/item_linking.rb for
    # more information.
    #
    
    create_table :item_linkings do |t|
      t.references :item
      t.references :item_linkings, :polymorphic => true
    end
    
    create_table :item_files do |t|
      # My current plan is to reference files on disk rather than go storing 
      # sodding great blobs in the database. -NS 2008-04-28
      t.references :item
      t.string :url
      t.timestamps
    end
    
    create_table :shows do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :people do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :organisations do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :events do |t|
      t.references :show, :venue
      t.datetime :start
      t.datetime :end
      t.timestamps
    end

    create_table :venues do |t|
      t.string :name
      t.timestamps
    end
    
    #
    # Create join tables for n2n relationships.
    #
    
    create_table :show_roles do |t|
      t.references :person, :show
      t.string :name
    end
    
    create_table :organisation_roles do |t|
      t.references :organisation, :person
      t.string :name
    end
    
    create_table :organisations_shows do |t|
      t.references :organisation, :show
    end
    
  end

  def self.down
    drop_table :items
    drop_table :item_linkings
    drop_table :item_files
    drop_table :shows
    drop_table :people
    drop_table :organisations
    drop_table :events
    drop_table :venues
    
    drop_table :show_roles
    drop_table :organisation_roles
    drop_table :organisations_shows
  end
end
