class SongPerformanceSerializer < ActiveModel::Serializer
  attributes :id, :set_position, :song_name, :set_number

  # Doesn't actually represent schema. Is this ok?
  def song_name
    object.song.name
  end

  def set_number
    object.concert_set.set_number
  end

  has_one :song do
    song = object.song
    link(:self) { api_v1_song_url(song)}
  end
end
