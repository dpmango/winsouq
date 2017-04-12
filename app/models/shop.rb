require 'elasticsearch/model'

class Shop < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :products
  has_many :views
  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :products

  extend FriendlyId
  friendly_id :title, use: :slugged

  mount_uploader :image, ShopUploader

  geocoded_by :location
  after_validation :geocode
  reverse_geocoded_by :latitude, :longitude

  validates :title, presence: true

  def self.search_with_elasticsearch(*args,&block)
    __elasticsearch__.search(*args, &block)
  end

end

Shop.import
