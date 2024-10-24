module Api
  module V1
    class BaseController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_user!, unless: :devise_controller?
      before_action :configure_permitted_parameters, if: :devise_controller?
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_in, key: [:email, :password])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
      end

      private


    end
  end
end
