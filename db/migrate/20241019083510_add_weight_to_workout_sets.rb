class AddWeightToWorkoutSets < ActiveRecord::Migration[7.1]
  def change
    add_column :workout_sets, :weight, :float
  end
end
