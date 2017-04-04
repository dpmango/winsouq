class Shop < ApplicationRecord

  has_many :products
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: :slugged

end
