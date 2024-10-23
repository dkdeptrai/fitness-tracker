# == Schema Information
#
# Table name: exercises
#
#  id              :bigint           not null, primary key
#  created_by_user :boolean
#  description     :text
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_exercises_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Exercise < ApplicationRecord
  has_and_belongs_to_many :muscle_groups
  has_and_belongs_to_many :exercise_categories
  has_many :workout_sets, dependent: :destroy
  belongs_to :user
end
