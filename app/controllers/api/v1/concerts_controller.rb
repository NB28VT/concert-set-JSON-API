class Api::V1::ConcertsController < ApplicationController
  before_action :get_concert, only: [:show]

  def index
    concerts = Concert.merge(search_params).all.paginate(page: params[:page], per_page: params[:per_page])


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
