FactoryBot.define do
  factory :item do
    name { Faker::Company.name }
    description { Faker::Address.city }
    unit_price { Faker::Number.positive(from = 1.00, to = 5000.00) }
    id { Faker::Number.unique.within(range: 1..100_000) }
  end
end
