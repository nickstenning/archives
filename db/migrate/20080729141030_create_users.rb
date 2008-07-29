class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :camdram_number
      t.string :camdram_loginname
      t.string :camdram_realname
      t.references :person

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
