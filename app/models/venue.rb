# frozen_string_literal: true

class Venue < ApplicationRecord
  has_many_attached :photos

  has_many :bedrooms, dependent: :destroy
  has_many :bathrooms, dependent: :destroy
  has_many :keys, dependent: :destroy
  has_many :internets, dependent: :destroy
  has_many :digital_codes, dependent: :destroy
  has_many :home_services, dependent: :destroy

  belongs_to :creator, class_name: "User"
end
