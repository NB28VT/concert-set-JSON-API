class SongPerformance < ApplicationRecord
  belongs_to :concert
  belongs_to :song
  belongs_to :set
end
