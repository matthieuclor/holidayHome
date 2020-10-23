# frozen_string_literal: true

class FamilyLink < ApplicationRecord
  belongs_to :user
  belongs_to :family, inverse_of: :family_links
  belongs_to :premium_user, -> { where(plan: :premium) },
                            foreign_key: :user_id,
                            class_name: "User",
                            optional: true

  validates :family, :user, presence: true
end
