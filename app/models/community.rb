class Community < ApplicationRecord
  validates :name, presence: true, length: {maximum: 20 }

  belongs_to :user
  has_many   :messages,  dependent: :destroy
  has_many   :favorites, dependent: :destroy
end
