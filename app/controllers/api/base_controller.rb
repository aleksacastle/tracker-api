module Api
  class BaseController < ActionController::API
    include ActionController::Serialization

    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::ParameterMissing, with: :bad_request
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ActionDispatch::ShowExceptions, with: :internal_server_error

    private

    def not_found
      render json: {
        error_message: "Not found"
      }, status: :not_found
    end

    def bad_request
      render json: {
        error_message: "Something wrong"
      }, status: :bad_request
    end

    def unprocessable_entity
      render json: {
        error_message: "Record is invalid"
      }, status: :unprocessable_entity
    end

    def internal_server_error
      render json: {
        error_message: "Internal server error"
      }, status: :forbidden
    end
  end
end
