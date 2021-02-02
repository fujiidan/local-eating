class Profile < ApplicationRecord
  validates :address, presence: true
  validates :latitude, :longitude, numericality: { message: 'が算出されません、適切な住所を入力してください' }
  geocoded_by :address
  before_validation :geocode

  belongs_to :user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :sex
end
