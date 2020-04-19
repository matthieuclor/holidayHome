# frozen_string_literal: true

class Venue < ApplicationRecord
  has_many_attached :photos, dependent: :destroy

  has_many :bedrooms, dependent: :destroy
  has_many :bathrooms, dependent: :destroy
  has_many :keys, dependent: :destroy
  has_many :networks, dependent: :destroy
  has_many :digital_codes, dependent: :destroy
  has_many :home_services, dependent: :destroy

  belongs_to :creator, class_name: "User"
  belongs_to :family

  default_scope { order(:created_at) }

  accepts_nested_attributes_for :bedrooms, :keys, :networks,
                                reject_if: -> (attr) { attr['name'].blank? },
                                allow_destroy: true

  accepts_nested_attributes_for :bathrooms, :digital_codes, :home_services,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates :name, :address, :creator, :family, presence: true

    # validates :name,
    #         :address,
    #         :city,
    #         :postcode,
    #         :country,
    #         :country_code,
    #         :administrative,
    #         :county,
    #         :lat,
    #         :lng,
    #         :with_network,
    #         :with_digital_code,
    #         :with_home_service,
    #         :editable_for_others,
    #         :creator,
    #         :family, presence: true

    validates :with_network,
              :with_digital_code,
              :editable_for_others,
              :with_home_service,
              inclusion: { in: [true, false] }

  validates :name, uniqueness: { scope: :family_id }

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
      venue.errors self.errors.messages
    end
  end
end
