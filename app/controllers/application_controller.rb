class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  wrap_parameters false
end
