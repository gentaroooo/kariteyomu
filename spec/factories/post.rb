FactoryBot.define do
  factory :post do
    sequence(:title, "title_1")
    body { 'レビュー内容です' }
    published_date { "2022-05-01" }
    info_link { 'https://google.com' }
    association :user
  end
end
