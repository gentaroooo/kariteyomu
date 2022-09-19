FactoryBot.define do
  factory :book_author do
    association :book
    association :author
  end
end
