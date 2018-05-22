class Api::V1::VenuesController < ApplicationController
  def index
    venues = Venue.all.paginate(page: params[:page])

    render json: venues, meta: pagination_meta(venues)
  end

  def show
    venue = Venue.find(params[:id])

    render json: venue
  end

  def concerts
    venue = Venue.find(params[:id])
    concerts = venue.concerts.paginate(page: params[:page])

    render json: concerts, each_serializer: ConcertIndexSerializer, meta: pagination_meta(concerts)
  end

  private

  def pagination_meta(object)
    {
      total_results: object.total_entries,
      total_pages: object.total_pages
    }
  end
end
