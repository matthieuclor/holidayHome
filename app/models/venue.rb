# frozen_string_literal: true

require 'open-uri'

class Venue < ApplicationRecord
  GOOGLE_MAP_SEARCH_URL = 'https://www.google.com/maps/search/'
  GOOGLE_MAP_URL = 'https://maps.googleapis.com/maps/api/staticmap'
  GOOGLE_MAP_ZOOM = '11'
  GOOGLE_MAP_SIZE = '400x400'
  GOOGLE_MAP_TYPE = 'roadmap'
  GOOGLE_MAP_FORMAT = 'png'

  has_many_attached :photos
  has_one_attached :map

  belongs_to :creator, class_name: 'User'
  belongs_to :family, counter_cache: true

  has_many :keys, dependent: :destroy
  has_many :networks, dependent: :destroy
  has_many :digital_codes, dependent: :destroy
  has_many :home_services, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :bookings, dependent: :destroy

  default_scope { order(:created_at) }

  accepts_nested_attributes_for :keys, :networks,
                                reject_if: ->(attr) { attr['name'].blank? },
                                allow_destroy: true

  accepts_nested_attributes_for :digital_codes, :home_services,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates_with VenueValidFromPlan, on: :create

  validates :photos, content_type: %i(png jpg jpeg),
                     size: { less_than: 2.megabytes }
  validates :photos, limit: { max: 10 }
  validates :photos, limit: { max: User::PLAN_BASIC_LIMIT[:venues_photos] },
                     unless: ->(venue) { venue.creator&.families&.first&.premium? }

  validates :map, content_type: :png, size: { less_than: 1.megabyte }

  validates :name,
            :address,
            :creator,
            :family,
            :bedrooms_count,
            :bathrooms_count,
            :single_beds_count,
            :double_beds_count,
            :baby_beds_count,
            :single_sofa_beds_count,
            :double_sofa_beds_count,
            presence: true

  validates :bedrooms_count,
            :bathrooms_count,
            :single_beds_count,
            :double_beds_count,
            :baby_beds_count,
            :single_sofa_beds_count,
            :double_sofa_beds_count,
            numericality: { greater_than_or_equal_to: 0 }

  validates :with_network,
            :with_digital_code,
            :with_washing_machine,
            :with_tumble_dryer,
            :with_dishwasher,
            :editable_for_others,
            :with_home_service,
            inclusion: { in: [true, false] }

  validates :name, uniqueness: { scope: :family }

  before_save :attach_map, if: ->(obj) { obj.lat_changed? || obj.lng_changed? }
  before_save :remove_nested_objects

  private

  def attach_map
    map.attach(
      io: open( # rubocop:disable Security/Open
        GOOGLE_MAP_URL +
        "?center=#{lat},#{lng}" \
        "&zoom=#{GOOGLE_MAP_ZOOM}" \
        "&size=#{GOOGLE_MAP_SIZE}" \
        "&maptype=#{GOOGLE_MAP_TYPE}" \
        "&markers=#{lat},#{lng}" \
        "&format=#{GOOGLE_MAP_FORMAT}" \
        "&key=#{Rails.application.credentials.dig(:google, :secret_access_key)}"
      ),
      filename: "#{name.parameterize}.#{GOOGLE_MAP_FORMAT}"
    )
  end

  def remove_nested_objects
    return if with_network && with_digital_code && with_home_service

    Network.destroy(networks.pluck(:id)) unless with_network
    DigitalCode.destroy(digital_codes.pluck(:id)) unless with_digital_code
    HomeService.destroy(home_services.pluck(:id)) unless with_home_service
  end
end
