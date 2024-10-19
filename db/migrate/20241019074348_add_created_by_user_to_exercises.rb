class AddCreatedByUserToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :created_by_user, :boolean
    add_reference :exercises, :user, null: false, foreign_key: true
  end
end
