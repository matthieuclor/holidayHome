# frozen_string_literal: true

class HomeService < ApplicationRecord
  belongs_to :venue

  validates :name, :person_in_charge, :venue, presence: true
  validates :name, uniqueness: { scope: :venue }
  validates :email, format: { with: Devise.email_regexp }, allow_blank: true
end
