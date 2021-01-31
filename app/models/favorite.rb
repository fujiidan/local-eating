class Favorite < ApplicationRecord
  validates :user_id, uniqueness: { scope: :community_id }

  belongs_to :user
  belongs_to :community
end
