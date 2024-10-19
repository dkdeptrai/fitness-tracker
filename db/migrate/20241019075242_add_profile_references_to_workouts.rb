class AddProfileReferencesToWorkouts < ActiveRecord::Migration[7.1]
  def change
    add_reference :workouts, :profile, null: false, foreign_key: true
  end
end
