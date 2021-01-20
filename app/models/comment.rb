class Comment < ApplicationRecord
  validates :comment, presence: true, unless: :was_attached?

  belongs_to :user
  belongs_to :store
  has_many_attached :comment_images, dependent: :destroy

  def was_attached?
    self.images.attached?
  end
end
