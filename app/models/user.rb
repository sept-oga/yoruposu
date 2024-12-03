class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :name, length: { maximum: 20 }
  validates :introduction, length: { maximum: 200 }

  has_one_attached :profile_image

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/javascript/images/no-image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end

  # 検索
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      # SecureRandom.urlsafe_base64：ランダムな文字列を生成する
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
end
