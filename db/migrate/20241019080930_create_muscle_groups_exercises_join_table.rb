class CreateMuscleGroupsExercisesJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :muscle_groups_exercises do |t|
      t.references :muscle_group, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
