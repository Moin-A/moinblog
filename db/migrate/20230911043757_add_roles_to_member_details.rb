class AddRolesToMemberDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :member_details, :super_admin, :boolean
    add_column :member_details, :guest, :boolean
    add_column :member_details, :author, :boolean
  end
end
