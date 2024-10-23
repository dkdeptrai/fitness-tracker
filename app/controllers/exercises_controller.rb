class ExercisesController < ApplicationController

  include AuthentiÏcatable

  before_action :set_exercise, only: %i[show edit update destroy]
  before_action :set_exercise_category
  before_action :set_workout
  before_action :authenticate_user!
  before_action :ensure_admin!

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to @workout, notice: 'Exercise was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise.destroy
    redirect_to @workout, notice: 'Exercise was successfully destroyed.'
  end

  def new
    @exercise = @workout.exercises.new
  end

  def show
  end

  def create
    @exercise = @workout.exercises.build(exercise_params)
    Rails.logger.debug("Incoming params: #{params.inspect}")

    Rails.logger.debug("Exercise params: #{params[:exercise].inspect}")
    if @exercise.save
      respond_to do |format|
        format.html { redirect_to @workout, notice: 'Exercise was successfully created.' }
        format.turbo_stream
      end
    else
      Rails.logger.debug("Error saving exercise: #{@exercise.errors.full_messages}")
      render @workout, status: :unprocessable_entity, notice: 'Exercise was not created.'
    end
  end

  def index
    @exercises = Exercise.all
  end

  private

  def exercise_params
    params.require(:exercise).permit(:workout_id, :name, :sets, :reps, :weight)
  end

  def set_workout
    @workout = Workout.find(params[:workout_id])
  end

  def set_exercise_category
    @exercise_category = ExerciseCategory.find(params[:exercise_category_id])
  end

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def ensure_admin!
    return if current_user.admin?

    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end
end
