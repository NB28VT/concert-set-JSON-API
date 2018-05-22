class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :state

  link(:self) { api_v1_venue_url(object) }
  has_many :concerts do
    link(:related) { concerts_api_v1_venue_url(object)}
  end

end
