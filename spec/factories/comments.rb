FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.sentence }
    association :user
    association :store

    after(:build) do |comment|
      comment.comment_images.attach(io: File.open('public/images/test_image2.png'), filename: 'test_image2.png')
    end
  end
end
