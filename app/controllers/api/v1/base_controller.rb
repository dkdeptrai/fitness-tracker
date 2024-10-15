module Api
  module V1
    class BaseController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :configure_permitted_parameters, if: :devise_controller?

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_in, key: [:email, :password])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
      end
    end
  end
end
