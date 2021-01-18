FactoryBot.define do
  factory :user do
    nickname                 { Gimei.name }
    email                    { Faker::Internet.free_email }
    password                 { "1a#{Faker::Internet.password(min_length: 4, mix_case: false)}" }
    password_confirmation    { password }
  end
end
