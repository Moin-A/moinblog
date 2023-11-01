class AddIndexesToTables < ActiveRecord::Migration[7.0]
  def change
    add_index :comments, [:post_id, :user_id]   
    add_index :post_tags, [:post_id, :tag_id]
  end
end
