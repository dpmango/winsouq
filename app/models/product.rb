class Product < ApplicationRecord
  belongs_to :shop

  mount_uploader :image, ProductUploader

  validates :name, presence: true
  validates :price, presence: true

end
