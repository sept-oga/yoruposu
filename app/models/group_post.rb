class GroupPost < ApplicationRecord
  has_one_attached :gp_image
  belongs_to :group
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true

  def get_gp_image
    unless gp_image.attached?
      file_path = Rails.root.join('app/javascript/images/no-image-post.jpeg')
      gp_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    gp_image
  end

end
