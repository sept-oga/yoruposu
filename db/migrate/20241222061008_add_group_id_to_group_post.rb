class AddGroupIdToGroupPost < ActiveRecord::Migration[6.1]
  def change
    add_column :group_posts, :group_id, :integer
  end
end
