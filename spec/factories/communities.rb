FactoryBot.define do
  factory :community do
    name { 'テストコミュニティ' }
    association :user
  end
end
