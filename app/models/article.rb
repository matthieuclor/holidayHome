# frozen_string_literal: true

class Article < ApplicationRecord
  has_rich_text :body

  validates :title, :body, :slug, presence: true
  validates :title, :slug, uniqueness: true

  before_validation -> { self.slug = title.parameterize }
end
