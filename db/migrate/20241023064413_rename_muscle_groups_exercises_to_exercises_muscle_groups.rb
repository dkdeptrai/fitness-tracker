class RenameMuscleGroupsExercisesToExercisesMuscleGroups < ActiveRecord::Migration[7.1]
  def change
    rename_table :muscle_groups_exercises, :exercises_muscle_groups
  end
end
