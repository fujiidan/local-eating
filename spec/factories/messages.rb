FactoryBot.define do
  factory :message do
    message { Faker::Lorem.sentence }
    association :user
    association :community

    after(:build) do |message|
      message.message_images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
