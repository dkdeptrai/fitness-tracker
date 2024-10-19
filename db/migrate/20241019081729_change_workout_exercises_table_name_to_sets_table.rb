class ChangeWorkoutExercisesTableNameToSetsTable < ActiveRecord::Migration[7.1]
  def change
    rename_table :workout_exercises, :sets

    remove_column :sets, :sets, if_exists: true
  end
end
