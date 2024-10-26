class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[show edit update destroy]
  before_action :set_exercise_categories
  before_action :set_muscle_groups
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @exercises = Exercise.all
  end

  def show

  end

  def new
    @exercise = Exercise.new
  end

  def create
    created_by_user = !current_user.admin?
    muscle_groups = MuscleGroup.where(id: exercise_params[:muscle_group_ids])
    @exercise = current_user.exercises.build(exercise_params.merge(
      created_by_user: created_by_user,
      muscle_groups: muscle_groups,
    ))

    if @exercise.save
      redirect_to @exercise, notice: 'Exercise was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    muscle_groups = MuscleGroup.where(id: exercise_params[:muscle_group_ids])
    if @exercise.update(exercise_params.merge(muscle_groups: muscle_groups))
      redirect_to @exercise, notice: 'Exercise was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise.destroy!

    redirect_to exercises_path, notice: 'Exercise was successfully destroyed.'
  end

  def exercise_params
    params.require(:exercise).permit(:name, :description, :exercise_category_id , muscle_group_ids: [])
  end

  def set_exercise_categories
    @exercise_categories = ExerciseCategory.all
  end

  def set_muscle_groups
    @muscle_groups = MuscleGroup.all
  end

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def ensure_admin!
    return if current_user.admin?

    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end
end
