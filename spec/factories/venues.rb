FactoryBot.define do
  factory :venue do
    name Faker::Address.city
    state Faker::Address.state
  end
end
