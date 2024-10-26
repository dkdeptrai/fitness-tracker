module Api
  module V1
    class WorkoutSetsController < BaseController
      before_action :set_workout_set, only: %i[show update destroy]
      before_action :set_workout, only: %i[create]
      before_action :authorize_user!, only: %i[update destroy]

      def index
        @workout_sets = WorkoutSet.all
        render json: @workout_sets
      end

      def show
        render json: @workout_set
      end

      def create
        workout = Workout.find(params[:workout_id])
        exercise = Exercise.find(params[:exercise_id])

        workout_set = workout.workout_sets.create!(workout_set_params.merge(exercise: exercise))
        render json: workout_set, status: :created
      end

      def update
        @workout_set.update!(workout_set_params)
        render json: @workout_set
      end

      def destroy
        @workout_set.destroy
        head :no_content
      end

      private

      def workout_set_params
        params.require(:workout_set).permit(:reps, :weight, :rest_time, :exercise_id)
      end

      def set_workout_set
        @workout_set = WorkoutSet.find(params[:id])
      end

      def set_workout
        @workout = Workout.find(params[:workout_id])
      end
    end
  end
end
