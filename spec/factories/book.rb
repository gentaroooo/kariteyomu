FactoryBot.define do
  factory :book do
    sequence(:title, "title_1")
    published_date { "2022-05-01" }
    info_link { 'https://google.com' }
    image_link { 'https://google.com' }
    sequence(:systemid, 'isbn_1')
    association :user
  end
end
