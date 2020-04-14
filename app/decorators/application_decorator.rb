# frozen_string_literal: true

class ApplicationDecorator < SimpleDelegator
  def self.wrap(collection)
    collection.map { |obj| new(obj) }
  end
end
