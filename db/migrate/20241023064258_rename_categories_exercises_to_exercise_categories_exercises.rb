class RenameCategoriesExercisesToExerciseCategoriesExercises < ActiveRecord::Migration[7.1]
  def change
    rename_table :categories_exercises, :exercise_categories_exercises
  end
end
