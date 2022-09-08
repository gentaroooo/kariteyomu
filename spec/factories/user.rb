FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "sample#{n}@example.com" }
    sequence(:name) { |n| "first_name{n}" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end