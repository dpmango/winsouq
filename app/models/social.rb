class Social < ApplicationRecord
  belongs_to :shop

  mount_uploader :image, SocialUploader

  validates :link, presence: true

end
