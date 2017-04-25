class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :shops, dependent: :destroy

  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'

  has_many :personal_messages, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_products, through: :favorites, source: :favorited, source_type: 'Product'
  has_many :favorite_shops, through: :favorites, source: :favorited, source_type: 'Shop'

  has_many :views, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  def name
    email.split('@')[0]
  end

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end

end
