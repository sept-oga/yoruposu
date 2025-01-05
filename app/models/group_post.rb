class GroupPost < ApplicationRecord
  has_one_attached :gp_image

  belongs_to :group_member

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode

  def get_gp_image
    unless gp_image.attached?
      file_path = Rails.root.join('app/javascript/images/no-image-post.jpeg')
      gp_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    gp_image
  end

end
