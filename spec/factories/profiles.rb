FactoryBot.define do
  factory :profile do
    address       { '東京タワー' }
    age           { rand(1..100) }
    sex_id        { rand(1..2) }
    association :user
    after(:build) do |profile|
      profile.profile_image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
