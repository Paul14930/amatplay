class Club < ApplicationRecord
  has_many :cameras, dependent: :destroy

  validates :name, presence: true
  validates :location, presence: true
  has_one_attached :image

  def upload_image(file)
    result = CloudflareImageUploader.upload_image(file)
    if result['success']
      update(image_id: result['result']['id'])
    else
      errors.add(:image, "Upload failed: #{result['errors']}")
      false
    end
  end

end
