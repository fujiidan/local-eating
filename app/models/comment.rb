class Comment < ApplicationRecord
  validates :comment, presence: { message: 'か画像は。どちらかは入力してください' }, unless: :was_attached?
  validates :comment, length: { maximum: 200 }
  validates :comment_images, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif'], limit: { max: 6 }

  belongs_to        :user
  belongs_to        :store
  has_many_attached :comment_images, dependent: :destroy

  def was_attached?
    comment_images.attached?
  end
end
