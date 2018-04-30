class Song < ApplicationRecord
  has_many :song_performances

  validates_presence_of :name
end
