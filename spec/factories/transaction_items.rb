FactoryGirl.define do
  factory :transaction_item do
    transient do
      pricing {}
    end

    product { pricing.product if pricing.present? }
    price { pricing.price if pricing.present? }
    name { pricing.product.name if pricing.present? }
  end
end
