class CreateGroupPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :group_posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
