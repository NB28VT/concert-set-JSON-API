class Api::V1::ConcertsController < ApplicationController
  before_action :get_concert, only: [:show]

  def index
    concerts = Concert.paginate(page: params[:page])

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
