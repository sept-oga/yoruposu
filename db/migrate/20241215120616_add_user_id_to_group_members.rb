class AddUserIdToGroupMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :group_members, :user_id, :integer
  end
end
