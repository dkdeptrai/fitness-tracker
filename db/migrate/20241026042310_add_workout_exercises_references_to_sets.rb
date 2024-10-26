class AddWorkoutExercisesReferencesToSets < ActiveRecord::Migration[7.1]
  def change
    rename_table :set, :sets
    add_reference :sets, :workout_exercises, null: false, foreign_key: true
  end
end
