class RemoveUserIdFromGroupPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :group_posts, :user_id, :integer
  end
end
