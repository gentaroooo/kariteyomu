FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "sample#{n}@example.com" }
    sequence(:name) { |n| "name{n}" }
    password { 'password' }
    password_confirmation { 'password' }

    trait :guest do
      role { :guest }
    end

    trait :admin do
      sequence(:email) { |n| "admin_#{n}@example.com" }
      role { :admin }
    end

    trait :general do
      sequence(:email) { |n| "general_#{n}@example.com" }
      role { :general }
    end
  end
end