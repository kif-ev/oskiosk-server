FactoryGirl.define do
  factory :transaction do
    transient do
      items []
    end

    transaction_type 'some_type'
    user_name { user.name if user.present? }
    created_at { DateTime.now }

    after(:create) do |transaction, evaluator|
      evaluator.items.each do |item|
        create :transaction_item,
               pricing: item[:pricing],
               quantity: item[:quantity],
               transaction_id: transaction.id
      end
    end
  end
end
