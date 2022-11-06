FactoryBot.define do
  factory :library do
    name { 'Kanagawa_Hiratsuka' }
    association :user
  end
end
