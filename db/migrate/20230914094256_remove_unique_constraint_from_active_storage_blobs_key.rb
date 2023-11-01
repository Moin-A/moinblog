class RemoveUniqueConstraintFromActiveStorageBlobsKey < ActiveRecord::Migration[7.0]
  def up
    remove_index :active_storage_blobs, :key
    change_column :active_storage_blobs, :key, :string, unique: false
    add_index :active_storage_blobs, :key  # Re-add the non-unique inde
  end

  def down
    remove_index :active_storage_blobs, :key
    change_column :active_storage_blobs, :key, :string, unique: false
    add_index :active_storage_blobs, :key  # Re-add the non-unique inde
  end
end
