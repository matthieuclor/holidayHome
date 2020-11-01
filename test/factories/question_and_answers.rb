# frozen_string_literal: true

FactoryBot.define do
  factory :question_and_answer do
    question { Faker::Movies::StarWars.quote }
    answer { Faker::Movies::StarWars.wookiee_sentence }
    status { 0 }
  end
end
