# frozen_string_literal: true

class HomeService < ApplicationRecord
  belongs_to :venue, counter_cache: true

  validates :name, :person_in_charge, :venue, presence: true
  validates :name, uniqueness: { scope: :venue_id }
  validates :email, format: { with: Devise.email_regexp }
end
