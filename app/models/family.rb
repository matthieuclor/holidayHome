# frozen_string_literal: true

class Family < ApplicationRecord
  has_many :family_links, dependent: :destroy
  has_many :users, through: :family_links
  has_many :invitations, dependent: :destroy
  has_many :venues, dependent: :destroy

  default_scope { order(:created_at) }

  validates :name, presence: true
end
