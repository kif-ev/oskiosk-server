FactoryBot.define do
  factory :user do
    transient do
      sequence(:code) {|n| "U#{n}"}
    end
    after(:create) do |user, evaluator|
      create(:identifier, identifiable: user, code: evaluator.code)
    end
  end
end
