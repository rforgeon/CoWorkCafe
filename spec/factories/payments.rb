FactoryGirl.define do
  factory :payment do
    amount "9.99"
    user_id 1
    stripe_id 1
  end
end
