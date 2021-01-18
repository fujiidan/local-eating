FactoryBot.define do
  factory :store do
    name            { 'テスト店舗' }
    address         { Gimei.address.kanji }
    latitude        { Faker::Address.latitude }
    longitude       { Faker::Address.longitude }
    url             { Faker::Internet.url }
    genre_id        { rand(1..16) }
    price_id        { rand(1..10) }
    info            { 'テスト店舗情報' }
    association :user

    after(:build) do |store|
      store.images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
