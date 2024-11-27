module Api
  module V1
    class WorkoutsController < BaseController
      before_action :set_profile
      before_action :set_workout, only, %i[show update destroy]
      def index

      end

      def show

      end

      def new
        @workout = Workout.new
      end

      def create
        @workout = Workout.new(workout_params)

        if @workout.save
          render json: @workout, status: :created
        else
          render json: @workout.errors, status: :unprocessable_entity
        end
      end

      def update
        if @workout.update(workout_params)
          redirect_to @workout, notice: 'Workout was successfully updated.'
        else
          render :edit, status: :unprocessable_entity
        end
      end

      private

      def workout_params
        params.require(:workout).permit(:name, :profile_id, :begin_time)
      end

      def set_profile
        @profile = Profile.where(users: current_user)
      end

      def set_workout
        @workout = Workout.find(params[:id])
      end
    end
  end
end
