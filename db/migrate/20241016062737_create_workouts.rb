class CreateWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :workouts do |t|
      t.timestamp :begin_time
      t.timestamp :end_time
      t.integer :duration, default: 0 # Use integer for storing duration in seconds or minutes
      t.integer :calories, default: 0
      t.string :name

      t.timestamps
    end
  end
end
