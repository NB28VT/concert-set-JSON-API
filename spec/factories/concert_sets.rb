FactoryBot.define do
  factory :concert_set do
    sequence(:position_id)
    concert
  end
end
