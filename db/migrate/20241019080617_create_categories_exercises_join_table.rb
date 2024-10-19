class CreateCategoriesExercisesJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :categories_exercises do |t|
      t.references :exercise_category, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
