# frozen_string_literal: true

FactoryBot.define do
  factory :family_link do
    user
    family
  end
end
