class Api::V1::ConcertsController < ApplicationController
  before_action :get_concert, only: [:show]

  def index
    # TODO: extract into something more usable when adding additional features
    year = params.dig("filter", "year")

    if year.present?
      concerts = Concert.during_year(year).paginate(page: params[:page])
    else
      concerts = Concert.paginate(page: params[:page])
    end

    render json: concerts, each_serializer: ConcertIndexSerializer
  end

  def show
    json_response(@concert)
  end

  private

  def get_concert
    @concert = Concert.find(params[:id])
  end
end
