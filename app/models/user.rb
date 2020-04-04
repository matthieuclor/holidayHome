class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :timeoutable, :confirmable, :lockable

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_one_attached :avatar
  has_many :family_links, dependent: :destroy
  has_many :families, through: :family_links

  enum step: %i(account_created family_created venue_created)
end
