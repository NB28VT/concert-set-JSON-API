class ConcertSerializer < ActiveModel::Serializer
  attributes :id, :show_date

  has_one :venue do
    venue = object.venue
    link(:self) {api_v1_venue_url(venue)}
  end

  has_many :song_performances do
    song_performances = object.song_performances
  end
end
