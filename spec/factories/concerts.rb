FactoryBot.define do
  factory :concert do
    # Needs to be in block, re executes each time:
    show_date { Faker::Date.between(30.years.ago, 1.day.ago) }
    venue
  end
end
