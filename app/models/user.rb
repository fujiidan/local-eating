class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: { case_sensitive: true }, length: { maximum: 10 }
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/, message: 'は半角英数字をそれぞれ１文字以上含めてください' }, on: :create

  has_one  :profile,     dependent: :destroy
  has_many :stores,      dependent: :destroy
  has_many :comments,    dependent: :destroy
  has_many :communities, dependent: :destroy
  has_many :messages,    dependent: :destroy
  has_many :likes,       dependent: :destroy
  has_many :favorites,   dependent: :destroy
  has_many :like_stores, through: :likes, source: :store
  has_many :favorite_communities, through: :favorites, source: :community

  def liked?(store_id)
    likes.where(store_id: store_id).exists?
  end

  def favorited?(community_id)
    favorites.where(community_id: community_id).exists?
  end
end
