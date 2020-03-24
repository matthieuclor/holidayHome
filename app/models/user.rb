class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :timeoutable

  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
  validates :password_confirmation, presence: true, on: :create
end
