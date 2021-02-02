class Message < ApplicationRecord
  validates :message, presence: { message: 'か画像は。どちらかは入力してください' }, unless: :was_attached?

  belongs_to        :user
  belongs_to        :community
  has_many_attached :message_images, dependent: :destroy

  def was_attached?
    message_images.attached?
  end
end
