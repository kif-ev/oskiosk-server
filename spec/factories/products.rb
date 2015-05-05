FactoryGirl.define do
  factory :product do
    transient do
      sequence(:code) {|n| "P#{n}"}
      quantity 5
      price 100
    end
    after(:create) do |product, evaluator|
      create :identifier, identifiable: product, code: evaluator.code
      if evaluator.quantity
        create :pricing,
               product: product,
               quantity: evaluator.quantity,
               price: evaluator.price
      end
    end
  end

  factory :product_without_pricings, parent: :product do
    transient do
      quantity nil
    end
  end
end
