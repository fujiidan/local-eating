FactoryBot.define do
  factory :comment do
    comment { 'テストコメント' }
    association :user
    association :store

    after(:build) do |comment|
      comment.comment_images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
