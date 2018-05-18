class SongPerformanceSerializer < ActiveModel::Serializer
  attributes :id, :set_position

  has_one :song do
    song = object.song
    link(:song) { api_v1_song_url(song)}
  end
end
