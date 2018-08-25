module Api
  class BaseController < ActionController::API
    include ActionController::Serialization
    include ExceptionHandler
  end
end
