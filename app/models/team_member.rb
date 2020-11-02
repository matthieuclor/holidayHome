# frozen_string_literal: true

class TeamMember < ApplicationRecord
  has_one_attached :photo, dependent: :destroy

  enum status: %i(offline online)

  default_scope { order(:created_at) }

  validates :first_name, :last_name, :function, presence: true
  validates :status, inclusion: { in: statuses.keys }

  before_save -> { first_name.capitalize! }, if: :first_name_changed?
  before_save -> { last_name.capitalize! }, if: :last_name_changed?
  before_save -> { function.capitalize! }, if: :function_changed?
end
