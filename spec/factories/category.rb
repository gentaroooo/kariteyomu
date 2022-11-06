FactoryBot.define do
  factory :category,class: Category do
    name { '幼稚園保育園' }
  end

  factory :category_2,class: Category  do
    name { '笑える' }
  end

  factory :category_3,class: Category  do
    name { '楽しい' }
  end
end
