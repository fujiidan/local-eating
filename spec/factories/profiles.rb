FactoryBot.define do
  factory :profile do
    address       { Gimei.address.kanji }
    latitude      { Faker::Address.latitude }
    longitude     { Faker::Address.longitude }
    age           { rand(1..100) }
    sex_id        { rand(1..2) }
    association :user
  end
end
