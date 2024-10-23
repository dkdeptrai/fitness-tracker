module Api
  module V1
    class ExercisesController < BaseController
      before_action :authenticate_user!, only: %i[create update destroy]
      before_action :authorize_user!, only: %i[update destroy]
      def create
        created_by_user = !current_user.admin?
        exercise = current_user.exercises.create!(exercise_params.merge(created_by_user))
        render json: exercise, status: :created
      end

      def update
        exercise = current_user.exercises.find(params[:id])
        exercise.update!(exercise_params)
        render json: exercise
      end

      def destroy
        exercise = current_user.exercises.find(params[:id])
        exercise.destroy
        head :no_content
      end

      private

      def exercise_params
        params.require(:exercise).permit(:name, :exercise_categories, :muscle_groups, :description)
      end

      def set_exercise
        @exercise = Exercise.find(params[:id])
      end

      def authorize_user!
        return if current_user.admin?

        unless @exercise.created_by_user && @exercise.user == current_user
          render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
        end
      end
    end
  end
end
