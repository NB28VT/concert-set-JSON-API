FactoryBot.define do
  factory :venue do
    name Faker::Address.city
  end
end
