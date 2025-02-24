class GroupMember < ApplicationRecord
  belongs_to :user
  belongs_to :group, dependent: :destroy
  has_many :group_posts, dependent: :destroy
end
