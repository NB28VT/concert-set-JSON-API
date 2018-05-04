class ConcertSet < ApplicationRecord
  belongs_to :concert
  has_many :song_performances, dependent: :destroy

  validates_presence_of :position_id
  validates_presence_of :concert_id
end
