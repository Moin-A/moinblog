class CreateMemberDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :member_details do |t|
      t.string :role
      t.text :biography
      t.text :social_media_links
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
