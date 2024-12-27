class AddGeocodingColumnToGroupPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :group_posts, :address, :string, :string, null: false, default: ""
    add_column :group_posts, :latitude, :float, null: false, default: 0
    add_column :group_posts, :longitude, :float, null: false, default: 0
  end
end
