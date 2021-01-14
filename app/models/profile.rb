class Profile < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to_active_hash :sex
end
