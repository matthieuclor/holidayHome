# frozen_string_literal: true

FactoryBot.define do
  factory :school_holiday do
    description { Faker::Movies::StarWars.specie + " holiday" }
    zone { ["Zone A", "Zone B", "Zone C"].sample }
    school_year { ["2018-2019", "2019-2020", "2020-2021"].sample }
    locations { ["Versailles", "Créteil", "Montpellier", "Paris", "Toulouse"].sample(3) }
    from { Faker::Date.in_date_period(year: 2020, month: 11) }
    to { Faker::Date.in_date_period(year: 2020, month: 12) }
  end
end
