class Profile < ApplicationRecord
  validates :age, length: { maximum: 3 }
  validates :address, presence: true
  validates :latitude, :longitude, numericality: { message: 'が算出されません、適切な住所を入力してください' }
  geocoded_by :address
  before_validation :geocode

  belongs_to :user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :sex

  def self.guest(user)
    find_or_create_by!(user_id: user.id) do |profile|
      profile.address = "東京タワー"
      profile.age = "20"
      profile.sex_id = "1"
    end
  end
end
