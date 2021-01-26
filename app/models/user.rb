class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: { case_sensitive: true }
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/, message: 'は半角英数字をそれぞれ１文字以上含めてください' }, on: :create

  has_many :stores, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :communities, dependent: :destroy
  has_many :messages , dependent: :destroy
end
