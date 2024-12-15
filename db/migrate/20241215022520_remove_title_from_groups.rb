class RemoveTitleFromGroups < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :title, :string
  end
end
