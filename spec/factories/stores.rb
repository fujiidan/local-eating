FactoryBot.define do
  factory :store do
    name            { Faker::Lorem.word }
    address         { Gimei.address.kanji }
    url             { Faker::Internet.url }
    genre_id        { rand(1..16) }
    price_id        { rand(1..10) }
    info            { Faker::Lorem.sentence }
    association :user

    after(:build) do |store|
      store.store_images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
