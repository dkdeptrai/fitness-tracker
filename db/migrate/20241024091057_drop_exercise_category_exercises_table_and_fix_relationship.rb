class DropExerciseCategoryExercisesTableAndFixRelationship < ActiveRecord::Migration[7.1]
  def change
    drop_table :exercise_categories_exercises

    add_reference :exercises, :exercise_category, foreign_key: true

  end
end
