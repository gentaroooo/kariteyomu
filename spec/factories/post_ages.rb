FactoryBot.define do
  factory :post_age do
    association :post
    association :age
  end
end
