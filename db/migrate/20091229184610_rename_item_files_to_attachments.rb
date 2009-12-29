class RenameItemFilesToAttachments < ActiveRecord::Migration
  def self.up
    rename_table(:item_files, :attachments)
  end

  def self.down
    rename_table(:attachments, :item_files)
  end
end
