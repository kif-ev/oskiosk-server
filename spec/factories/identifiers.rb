FactoryGirl.define do
  factory :identifier do
    sequence(:code) { |n| "#{n}" }
  end
end
