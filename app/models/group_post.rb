class GroupPost < ApplicationRecord
  has_one_attached :image
  belongs_to :group
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/javascript/images/no-image-post.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end
