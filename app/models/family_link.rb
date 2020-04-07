class FamilyLink < ApplicationRecord
  belongs_to :user
  belongs_to :family, inverse_of: :family_links

  validates :family, :user, presence: true
end
