class ConcertSerializer < ActiveModel::Serializer
  attributes :id

  has_one :venue
  # belongs_to :venue
  # has_many :concert_sets
end
