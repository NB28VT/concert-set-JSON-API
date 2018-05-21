class Api::V1::VenuesController < ApplicationController
  def index
    venues = Venue.all.paginate(page: params[:page])
    # Probably don't want to include concerts
    render json: venues, meta: pagination_meta(venues)
  end

  def concerts
    venue = Venue.find(params[:id])
    concerts = venue.concerts

    render json: concerts, each_serializer: ConcertIndexSerializer
  end

  private

  def pagination_meta(venues)
    {
      total_results: venues.total_entries,
      total_pages: venues.total_pages
    }
  end
end
