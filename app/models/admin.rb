class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable,
  # :recoverable, :rememberable and :omniauthable
  devise :database_authenticatable, :validatable

  validates :first_name, :last_name, presence: true
end
