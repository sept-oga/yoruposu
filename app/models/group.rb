class Group < ApplicationRecord
  has_one_attached :group_image
  belongs_to :owner, class_name: 'User'

  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members, source: :user
  has_many :group_posts, through: :group_members, source: :group_posts
  has_many :permits, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 50 }

  def get_group_image
    unless group_image.attached?
      file_path = Rails.root.join('app/javascript/images/no-image.jpeg')
      group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    group_image
  end

  def is_owned_by?(user)
    owner.id == user.id
  end
  
  def includesUser?(user)
    group_members.exists?(user_id: user.id)
  end

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
