class Store < ApplicationRecord
  with_options presence: true do
    validates :name, length: { maximum: 20 }
    validates :address
    validates :info, length: { maximum: 400 }
  end
  validates :url, format: { with: %r{https?:/{2}[\w/:%#{Regexp.last_match(0)}?()~.=+\-]+}, message: 'にはhttpまたはhttpsを含む必要があります' },
                  allow_blank: true
  validates :store_images, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif'], limit: { max: 10 }
  validates :latitude, :longitude, numericality: { message: 'が算出されません、適切な住所を入力してください' }
  validates :genre_id, :price_id, numericality: { only_integer: true, message: 'を選択してください' }
  geocoded_by :address
  before_validation :geocode
  belongs_to        :user
  has_many_attached :store_images, dependent: :destroy
  has_many          :comments,     dependent: :destroy
  has_many          :likes,        dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
  belongs_to_active_hash :price
end
