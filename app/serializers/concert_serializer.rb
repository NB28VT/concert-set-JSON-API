class ConcertSerializer < ActiveModel::Serializer
  attributes :id, :show_date

  has_one :venue, include: [:id, :name]
  has_many :concert_sets, key: :set
end
