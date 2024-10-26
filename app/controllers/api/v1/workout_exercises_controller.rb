module Api
  module V1
    class WorkoutExercisesController < BaseController
      before_action :set_workout_exercise, only: %i[show update destroy]

      def create
        @workout_exercise = WorkoutExercise.new(workout_exercise_params)

        if @workout_exercise.save
          render :show, status: :created
        else
          render json: @workout_exercise.errors, status: :unprocessable_entity
        end
      end

      private

      def workout_exercise_params
        params.require(:workout_exercise).permit(:workout_id, :exercise_id)
      end

      def set_workout_exercise
        @workout_exercise = @workout.workout_exercises.find(params[:id])
      end
    end
  end
end
