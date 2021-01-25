# class UserProfile
#   include ActiveModel::Model
#   attr_accessor :nickname, :email, :address, :age, :sex_id, :latitude, :longitude

#   validates :address, presence: true

#   delegate :persisted?, to: :user

#   def initialize(attributes = nil, user: User.new)
#     @user = user
#     attributes ||= default_attributes
#     super(attributes)
#   end

#   def update
#     ActiveRecord::Base.transaction do
#       User.update(@user.id, nickname: nickname, email: email)
#       @user.profile.update(address: address, latitude: latitude, longitude: longitude, age: age, sex_id: sex_id)
#     end
#   end

#   def to_model
#     user
#   end

#   private
#   attr_reader :user, :profile

#   def default_attributes
#     {
#       nickname: user.nickname,
#       email: user.email,
#       address: user.profile.address,
#       age: user.profile.age,
#       sex_id: user.profile.sex_id
#     }
#   end
# end
