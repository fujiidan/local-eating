FactoryBot.define do
  factory :community do
    name { Faker::Lorem.word }
    association :user
  end
end
