class RenameWorkoutSetsTableToSet < ActiveRecord::Migration[7.1]
  def change
    rename_table :workout_sets, :set
  end
end
