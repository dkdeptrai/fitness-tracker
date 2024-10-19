class CreateWorkoutSets < ActiveRecord::Migration[7.1]
  def change
    drop_table :workout_sets, if_exists: true

    create_table :workout_sets do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :reps

      t.timestamps
    end
  end
end
