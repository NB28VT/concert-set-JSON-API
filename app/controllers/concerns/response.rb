module Response
  def json_response(object, included= [], status = :ok)
    render json: object, status: status, include: included
  end
end
