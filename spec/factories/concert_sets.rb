FactoryBot.define do
  factory :concert_set do
    sequence(:position)
    concert
  end
end
