FactoryGirl.define do
  factory :owner do
    user nil
    address "MyString"
    state "MyString"
    city "MyString"
    zipcode 1
    description "MyText"
    rating 1.5
  end
end
