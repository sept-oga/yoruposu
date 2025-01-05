class AddGroupMemberIdToGroupPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :group_posts, :group_member_id, :integer
  end
end
