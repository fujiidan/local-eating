class Store < ApplicationRecord
  validates :name, :address, :info, presence: true
  validates :latitude, :longitude, numericality: { message: 'が算出されません、適切な住所を入力してください' }
  validates :genre_id, :price_id, numericality: { only_integer: true, message: 'を選択してください' }
  geocoded_by :address
  before_validation :geocode

  belongs_to :user
  has_many_attached :images
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
  belongs_to_active_hash :price
end
