FactoryBot.define do
  factory :song_performance do
    song
    concert_set
    sequence(:position)
  end
end
