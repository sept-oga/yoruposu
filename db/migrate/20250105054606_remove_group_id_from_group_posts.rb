class RemoveGroupIdFromGroupPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :group_posts, :group_id, :integer
  end
end
