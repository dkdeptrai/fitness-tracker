module Api
  module V1
    class BaseController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      # before_action :authenticate_user!, unless: :devise_controller?
      rescue_from StandardError, with: :render_internal_server_error
      rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      before_action :configure_permitted_parameters, if: :devise_controller?
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_in, key: [:email, :password])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
      end

      private


      def render_unprocessable_entity(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
      end

      def render_not_found(exception)
        render json: { error: exception.message }, status: :not_found
      end

      def render_internal_server_error(exception)
        render json: { error: "Something went wrong: #{exception.message}" }, status: :internal_server_error
      end
    end
  end
end
