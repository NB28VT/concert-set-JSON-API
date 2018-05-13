class ConcertIndexSerializer < ActiveModel::Serializer
  attributes :id, :show_date

  def show_date
    object.show_date.strftime("%m/%d/%Y")
  end

  has_one :venue
  link(:self) { api_v1_concert_url(object)}

end
