class SongPerformance < ApplicationRecord
  belongs_to :song
  belongs_to :concert_set

  validates_presence_of :song_id
  validates_presence_of :concert_set_id
  validates_presence_of :set_position
end
