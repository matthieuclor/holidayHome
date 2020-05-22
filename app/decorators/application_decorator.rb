# frozen_string_literal: true

class ApplicationDecorator < SimpleDelegator
  def self.wrap(collection)
    return unless collection
    collection.map { |obj| new(obj) }
  end
end
