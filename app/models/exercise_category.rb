# == Schema Information
#
# Table name: exercise_categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ExerciseCategory < ApplicationRecord
  has_many :exercises
  validates :name, presence: true
end
