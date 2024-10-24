module Api
  module V1
    class ExercisesController < BaseController
      before_action :set_exercise, only: %i[show update destroy]
      before_action :authorize_user!, only: %i[update destroy]
      def index
        @exercises = Exercise.all
        render json: @exercises
      end

      def show
        render json: @exercise
      end

      def create
        created_by_user = !current_user.admin?

        muscle_groups = MuscleGroup.where(id: exercise_params[:muscle_group_ids])
        exercise_category = ExerciseCategory.find(exercise_params[:exercise_category_id])

        exercise = current_user.exercises.create!(exercise_params.merge(
          created_by_user: created_by_user,
          muscle_groups: muscle_groups,
          exercise_category: exercise_category
        ))

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

      def search
        @exercises = Exercise.where('name ILIKE ?', "%#{params[:query]}%")
        render json: @exercises
      end

      private

      def exercise_params
        params.require(:exercise).permit(:name, :description, :exercise_category_id, muscle_group_ids: [])
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
