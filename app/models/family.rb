class Family < ApplicationRecord
  validates :name, presence: true

  has_many :family_links
  has_many :users, through: :family_links

  default_scope { order(:created_at) }
end
