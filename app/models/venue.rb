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

  has_many :bedrooms, dependent: :destroy
  has_many :bathrooms, dependent: :destroy
  has_many :keys, dependent: :destroy
  has_many :networks, dependent: :destroy
  has_many :digital_codes, dependent: :destroy
  has_many :home_services, dependent: :destroy

  belongs_to :creator, class_name: "User"
  belongs_to :family, counter_cache: true

  default_scope { order(:created_at) }

  accepts_nested_attributes_for :bedrooms, :keys, :networks,
                                reject_if: -> (attr) { attr['name'].blank? },
                                allow_destroy: true

  accepts_nested_attributes_for :bathrooms, :digital_codes, :home_services,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates :name, :address, :creator, :family, presence: true

  validates :with_network,
            :with_digital_code,
            :editable_for_others,
            :with_home_service,
            inclusion: { in: [true, false] }

  validates :name, uniqueness: { scope: :family_id }

  before_save :attach_map, if: -> (obj) { obj.lat_changed? || obj.lng_changed? }
  before_save :remove_nested_objects

  def to_builder
    Jbuilder.new do |venue|
      venue.(self,
             :id,
             :name,
             :address,
             :city,
             :postcode,
             :country,
             :country_code,
             :administrative,
             :county,
             :lat,
             :lng,
             :with_network,
             :with_digital_code,
             :with_home_service,
             :comment,
             :editable_for_others,
             :creator_id,
             :family_id)

      venue.bedrooms bedrooms.map { |bedroom| bedroom.to_builder.attributes! }
      venue.bathrooms bathrooms.map { |bathroom| bathroom.to_builder.attributes! }
      venue.keys keys.map { |key| key.to_builder.attributes! }
      venue.networks networks.map { |network| network.to_builder.attributes! }
      venue.digital_codes digital_codes.map { |digital_code| digital_code.to_builder.attributes! }
      venue.home_services home_services.map { |home_service| home_service.to_builder.attributes! }
      venue.errors self.errors.messages.transform_keys { |k| k.to_s.camelize(:lower) }
    end
  end

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
