require 'elasticsearch/model'

class Shop < ApplicationRecord
  if Rails.env.production?
    Elasticsearch::Model.client = Elasticsearch::Client.new url: ENV['BONSAI_URL'], log: true
  end
  include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
  after_commit on: [:create] do
    __elasticsearch__.index_document
  end

  after_commit on: [:update] do
    __elasticsearch__.index_document
  end

  after_commit on: [:destroy] do
    __elasticsearch__.delete_document
  end
  
  has_many :products
  has_many :views
  has_many :socials
  has_many :payments
  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :socials
  accepts_nested_attributes_for :payments

  extend FriendlyId
  friendly_id :title, use: :slugged

  mount_uploader :image, ShopUploader

  geocoded_by :location
  after_validation :geocode, if: ->(obj){ obj.location.present? and obj.location_changed? }
  reverse_geocoded_by :latitude, :longitude

  validates :title, presence: true

  def self.search_with_elasticsearch(*args,&block)
    __elasticsearch__.search(*args, &block)
  end

end

Shop.import force: true
