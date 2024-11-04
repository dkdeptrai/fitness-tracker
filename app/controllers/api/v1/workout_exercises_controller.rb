module Api
  module V1
    class WorkoutExercisesController < BaseController
      before_action :set_workout_exercise, only: %i[show update destroy]
      before_action :set_workout, only: %i[create]

      def show
        render json: @workout_exercise
      end
      def create
        @workout.workout_exercises.new(workout_exercise_params)

        if @workout.save
          render json: @workout, status: :created
        else
          render json: @workout.errors, status: :unprocessable_entity
        end
      end

      def update
        if @workout_exercise.update(workout_exercise_params)
          render json: @workout_exercise, status: :ok
        else
          render json: @workout_exercise.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @workout_exercise.destroy
        head :no_content
      end

      private

      def workout_exercise_params
        params.require(:workout_exercise).permit(:workout_id, :exercise_id)
      end

      def set_workout
        @workout = Workout.find(params[:workout_id])
      end

      def set_workout_exercise
        @workout_exercise = @workout.workout_exercises.find(params[:id])
      end
    end
  end
end
