FactoryBot.define do
  factory :post_author do
    association :post
    association :author
  end
end
