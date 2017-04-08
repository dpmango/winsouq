class Shop < ApplicationRecord

  has_many :products
  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :products

  extend FriendlyId
  friendly_id :title, use: :slugged

  mount_uploader :image, ShopUploader

  geocoded_by :location
  after_validation :geocode

  validates :title, presence: true


end
