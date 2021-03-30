FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    total_budget { 0.0 }
  end
end
