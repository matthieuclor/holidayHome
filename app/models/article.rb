# frozen_string_literal: true

class Article < ApplicationRecord
  has_rich_text :body

  enum status: %i(offline online)

  default_scope { order(:created_at) }

  validates :title, :slug, :body, presence: true
  validates :title, :slug, uniqueness: true
  validates :status, inclusion: { in: statuses.keys }

  before_validation -> { self.slug = title&.parameterize }
end
