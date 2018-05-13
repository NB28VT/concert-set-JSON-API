class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name

  link(:self) { api_v1_venue_url(object) }
end
