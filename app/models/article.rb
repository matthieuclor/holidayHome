# frozen_string_literal: true

class Article < ApplicationRecord
  has_rich_text :body

  enum status: %i(offline online)

  validates :title, :body, :slug, presence: true
  validates :title, :slug, uniqueness: true
  validates :status, inclusion: { in: statuses.keys }

  before_validation -> { self.slug = title.parameterize }
end
