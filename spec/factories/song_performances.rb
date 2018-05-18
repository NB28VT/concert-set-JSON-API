FactoryBot.define do
  factory :song_performance do
    song
    concert_set
    sequence(:set_position)
  end
end
