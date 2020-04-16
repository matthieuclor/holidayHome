# frozen_string_literal: true

class Venue < ApplicationRecord
  has_many_attached :photos

  has_many :bedrooms, dependent: :destroy
  has_many :bathrooms, dependent: :destroy
  has_many :keys, dependent: :destroy
  has_many :networks, dependent: :destroy
  has_many :digital_codes, dependent: :destroy
  has_many :home_services, dependent: :destroy

  belongs_to :creator, class_name: "User"

  accepts_nested_attributes_for :bedrooms, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :bathrooms, :keys, :networks, :digital_codes, :home_services,
    allow_destroy: true, reject_if: :all_blank

  validates :name, :address, :city, :postcode, :country, :country_code, :administrative,
    :county, :lat, :lng, :with_network, :with_digital_code, :editable_for_others, :creator,
    :family, presence: true
  validates :with_network, :with_digital_code, :editable_for_others, inclusion: { in: [true, false] }
  validates :name, uniqueness: { scope: :family_id }
end
