FactoryBot.define do
  factory :expense do
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    ammount { Faker::Number.decimal(l_digits: 2) }
    type { "income" }
    user { create(:user) }
  end
end
