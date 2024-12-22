class AddUserIdToGroupPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :group_posts, :user_id, :integer
  end
end
