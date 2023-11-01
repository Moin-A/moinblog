class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, charset: "utf8mb3", force: :cascade do |t|
      t.string "first_name"
      t.string "last_name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
