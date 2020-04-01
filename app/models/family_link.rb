class FamilyLink < ApplicationRecord
  validates :family, :user, presence: true

  belongs_to :user
  belongs_to :family, inverse_of: :family_links
end
