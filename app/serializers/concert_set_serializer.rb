class ConcertSetSerializer < ActiveModel::Serializer
  attributes :set_number

  def set_number
    object.position_id
  end
end
