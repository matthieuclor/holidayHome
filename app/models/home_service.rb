# frozen_string_literal: true

class HomeService < ApplicationRecord
  belongs_to :venue, counter_cache: true

  validates :name, :person_in_charge, :venue, presence: true
  validates :name, uniqueness: { scope: :venue_id }
  validates :email, format: { with: Devise.email_regexp }

  def to_builder
    Jbuilder.new do |home_service|
      home_service.(
        self,
        :id,
        :name,
        :person_in_charge,
        :address,
        :phone,
        :email,
        :_destroy)
    end
  end
end
