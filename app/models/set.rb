# == Schema Information
#
# Table name: workout_sets
#
#  id          :bigint           not null, primary key
#  reps        :integer
#  weight      :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  exercise_id :bigint           not null
#  workout_id  :bigint           not null
#
# Indexes
#
#  index_workout_sets_on_exercise_id  (exercise_id)
#  index_workout_sets_on_workout_id   (workout_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_id => exercises.id)
#  fk_rails_...  (workout_id => workouts.id)
#
class Set < ApplicationRecord
  belongs_to :workout_exercise, touch: true

  validates :reps, presence: true
  validates :reps, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :weight, presence: true
  validates :weight, numericality: { greater_than_or_equal_to: 0 }
  validates :workout_exercises_id, presence: true
end

