module ExceptionHandler

  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({message: e.message}, status: :not_found)
    end
  end

end
