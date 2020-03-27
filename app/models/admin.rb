class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable,
  # :recoverable, :rememberable, :validatable and :omniauthable
  devise :database_authenticatable

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
