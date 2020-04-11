FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8, max_length: 128) }

    factory :user_with_families do
      transient { families_count { 2 } }

      after(:create) do |user, evaluator|
        create_list(:family, evaluator.families_count, users: [user])
      end
    end
  end
end
