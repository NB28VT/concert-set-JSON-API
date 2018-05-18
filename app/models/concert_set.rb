class ConcertSet < ApplicationRecord
  belongs_to :concert
  has_many :song_performances, dependent: :destroy

  validates_presence_of :set_number
  validates_presence_of :concert_id
end
