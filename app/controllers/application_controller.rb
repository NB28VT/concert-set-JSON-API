class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  # Dunno if I need to include this manually?
  include ActionController::Serialization
end
