class Comment < ApplicationRecord
  validates :comment, presence: { message: 'か画像は。どちらかは入力してください' }, unless: :was_attached?

  belongs_to        :user
  belongs_to        :store
  has_many_attached :comment_images, dependent: :destroy

  def was_attached?
    comment_images.attached?
  end
end
