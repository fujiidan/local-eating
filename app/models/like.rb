class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: :store_id }

  belongs_to :user
  belongs_to :store
end
