FactoryBot.define do
  factory :invitation do
    association :sender, factory: :user
    association :receiver, factory: :user
    family
    email { Faker::Internet.email }
  end
end
