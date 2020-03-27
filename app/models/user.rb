class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :timeoutable, :confirmable, :lockable

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_one_attached :avatar
  has_and_belongs_to_many :families
end
