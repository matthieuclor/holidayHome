# frozen_string_literal: true

class QuestionAndAnswer < ApplicationRecord
  enum status: %i(offline online)

  default_scope { order(:created_at) }

  validates :question, :answer, presence: true
  validates :question, uniqueness: true
  validates :status, inclusion: { in: statuses.keys }
end
