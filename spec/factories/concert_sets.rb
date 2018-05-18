FactoryBot.define do
  factory :concert_set do
    sequence(:set_number)
    concert
  end
end
