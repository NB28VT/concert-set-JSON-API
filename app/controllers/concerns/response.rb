module Response
  def json_response(object, status: :ok, included: [])
    render json: object, status: status, include: included
  end
end
