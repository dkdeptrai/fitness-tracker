module Api
  module V1
    class WorkOutsController < BaseController
      before_action :set_profile
      def index

      end

      private

      def set_profile
        @profile = Profile.where(users: current_user)
      end
    end
  end
end
