class Comment < ApplicationRecord
  validates :comment presence: true, unless: :was_attached?

  belongs_to :user
  belongs_to :store
  has_many_attached :images, dependent: :destroy

  def was_attached?
    self.images.was_attached?
  end  
end
