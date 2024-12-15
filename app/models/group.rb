class Group < ApplicationRecord
  has_one_attached :image
  belongs_to :owner, class_name: 'User'

  has_many :group_members, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 50 }

  def get_group_image
    (image.attached?) ? image : 'no-image.jpeg'
  end

  def is_owned_by?(user)
    owner.id == user.id
  end
  
  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end
end
