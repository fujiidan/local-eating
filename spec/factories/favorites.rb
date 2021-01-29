FactoryBot.define do
  factory :favorite do
    association :user
    association :community  
  end
end
