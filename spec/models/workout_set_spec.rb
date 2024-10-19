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
require 'rails_helper'

RSpec.describe WorkoutSet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
