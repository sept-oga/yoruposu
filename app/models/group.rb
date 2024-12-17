class Group < ApplicationRecord
  has_one_attached :image
  belongs_to :owner, class_name: 'User'
  has_many :group_members, dependent: :destroy

  has_many :users, through: :group_members, source: :user
  
  validates :name, presence: true, length: { maximum: 50 }

  def get_group_image
    (image.attached?) ? image : 'no-image.jpeg'
  end

  def is_owned_by?(user)
    owner.id == user.id
  end
  
  def includesUser?(user)
    group_members.exists?(user_id: user.id)
  end

  # 検索
  def self.search_for(content, method)
    if method == 'perfect'
      Group.where(name: content)
    elsif method == 'forward'
      Group.where('name LIKE ?', content+'%')
    elsif method == 'backward'
      Group.where('name LIKE ?', '%'+content)
    else
      Group.where('name LIKE ?', '%'+content+'%')
    end
  end
end
