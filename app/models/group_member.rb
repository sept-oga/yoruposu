class GroupMember < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :group_posts
end
