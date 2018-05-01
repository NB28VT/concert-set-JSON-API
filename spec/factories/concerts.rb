FactoryBot.define do
  factory :concert do
    show_date Faker::Date.between(30.years.ago, 1.day.ago)
    venue
  end
end
