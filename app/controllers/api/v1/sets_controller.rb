module Api
  module V1
    class SetsController < BaseController
      before_action :set_workout_exercise
      before_action :set_set, only: %i[show update destroy]

      def show
        render :json => @set
      end

      def create
        @set = @workout_exercise.sets.new(set_params)
        if @set.save
          render :show, status: :created
        else
          render json: @set.errors, status: :unprocessable_entity
        end
      end

      def update
        if @set.update(set_params)
          render :show, status: :ok
        else
          render json: @set.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @set.destroy
        head :no_content
      end

      private

      def set_params
        params.require(:set).permit(:rep, :weight)
      end

      def set_workout_exercise
        @workout_exercise = WorkoutExercise.find(params[:workout_exercise_id])
      end

      def set_set
        @set = @workout_exercise.sets.find(params[:id])
      end
    end
  end
end
