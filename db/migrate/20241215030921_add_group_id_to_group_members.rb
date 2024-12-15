class AddGroupIdToGroupMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :group_members, :group_id, :integer
  end
end
