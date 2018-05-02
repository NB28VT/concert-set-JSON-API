class ConcertsController < ApplicationController
  before_action :get_concert, only: [:show]
  def show
    json_response(@concert)
  end

  private

  def get_concert
    @concert = Concert.find(params[:id])
  end
end
