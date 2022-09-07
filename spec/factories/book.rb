FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "タイトル#{n}" }
    sequence(:body) { |n| "本文#{n}" }
    association :user
  end
end