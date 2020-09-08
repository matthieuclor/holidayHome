# frozen_string_literal: true

require 'open-uri'

class Venue < ApplicationRecord
  GOOGLE_MAP_URL = "https://maps.googleapis.com/maps/api/staticmap"
  GOOGLE_MAP_ZOOM = "11"
  GOOGLE_MAP_SIZE = "400x400"
  GOOGLE_MAP_TYPE = "roadmap"
  GOOGLE_MAP_FORMAT = "png"

  has_many_attached :photos, dependent: :destroy
  has_one_attached :map, dependent: :destroy

  belongs_to :creator, class_name: "User"
  belongs_to :family, counter_cache: true

  has_many :keys, dependent: :destroy
  has_many :networks, dependent: :destroy
  has_many :digital_codes, dependent: :destroy
  has_many :home_services, dependent: :destroy
  has_many :bookings, dependent: :destroy

  default_scope { order(:created_at) }

  accepts_nested_attributes_for :keys, :networks,
                                reject_if: -> (attr) { attr['name'].blank? },
                                allow_destroy: true

  accepts_nested_attributes_for :digital_codes, :home_services,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates :photos, limit: { max: 10 },
                     content_type: [:png, :jpg, :jpeg],
                     size: { less_than: 2.megabytes }

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
            presence: true

  validates :with_network,
            :with_digital_code,
            :editable_for_others,
            :with_home_service,
            inclusion: { in: [true, false] }

  validates :name, uniqueness: { scope: :family_id }

  before_save :attach_map, if: -> (obj) { obj.lat_changed? || obj.lng_changed? }
  before_save :remove_nested_objects

  private

  def attach_map
    self.map.attach(
      io: open(
        GOOGLE_MAP_URL +
        "?center=#{self.lat},#{self.lng}" +
        "&zoom=#{GOOGLE_MAP_ZOOM}" +
        "&size=#{GOOGLE_MAP_SIZE}" +
        "&maptype=#{GOOGLE_MAP_TYPE}" +
        "&markers=#{self.lat},#{self.lng}" +
        "&format=#{GOOGLE_MAP_FORMAT}" +
        "&key=#{Rails.application.credentials.dig(:google, :secret_access_key)}"
      ),
      filename: "#{self.name.parameterize}.#{GOOGLE_MAP_FORMAT}"
    )
  end

  def remove_nested_objects
    return if self.with_network && self.with_digital_code && self.with_home_service

    Network.destroy(self.networks.pluck(:id)) unless self.with_network
    DigitalCode.destroy(self.digital_codes.pluck(:id)) unless self.with_digital_code
    HomeService.destroy(self.home_services.pluck(:id)) unless self.with_home_service
  end
end
