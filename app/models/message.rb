class Message < ApplicationRecord
  validates :message, presence: { message: 'か画像は。どちらかは入力してください' }, unless: :was_attached?
  validates :message, length: {maximum: 50}
  validates :message_images, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif'], limit: {max: 8}

  belongs_to        :user
  belongs_to        :community
  has_many_attached :message_images, dependent: :destroy

  def was_attached?
    message_images.attached?
  end
end
