class Community < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
