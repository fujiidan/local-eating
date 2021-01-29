FactoryBot.define do
  factory :like do
    association :user
    association :store
  end
end
