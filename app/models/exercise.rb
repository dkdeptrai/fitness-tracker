# == Schema Information
#
# Table name: exercises
#
#  id                   :bigint           not null, primary key
#  created_by_user      :boolean
#  description          :text
#  name                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  exercise_category_id :bigint
#  user_id              :bigint           not null
#
# Indexes
#
#  index_exercises_on_exercise_category_id  (exercise_category_id)
#  index_exercises_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_category_id => exercise_categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Exercise < ApplicationRecord
  has_and_belongs_to_many :muscle_groups
  belongs_to :exercise_category
  has_many :sets, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: true, length: {minimum: 1}
  validates :description, presence: true, length: {minimum: 1}
  validates :user_id, presence: true
  validates :created_by_user, inclusion: { in: [true, false] }
  validates :muscle_groups, presence: true
  validates :exercise_category, presence: true
end
