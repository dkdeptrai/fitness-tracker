# == Schema Information
#
# Table name: workouts
#
#  id         :bigint           not null, primary key
#  begin_time :datetime
#  calories   :integer          default(0)
#  duration   :integer          default(0)
#  end_time   :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :bigint           not null
#
# Indexes
#
#  index_workouts_on_profile_id  (profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (profile_id => profiles.id)
#
class Workout < ApplicationRecord
  belongs_to :profile
  has_many :workout_exercises, dependent: :destroy
  validates :begin_time, presence: true

  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :calories, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_save :set_name_to_begin_time

  private
  def set_name_to_begin_time
    if self.name.blank?
      self.name = begin_time.strftime("%Y-%m-%d %H:%M:%S")
    end
  end

  def complete_workout
    self.end_time = Time.now
    calculate_duration
  end

  def calculate_duration
    if self.begin_time && self.end_time
      self.duration = (self.end_time.to_i - self.begin_time.to_i)
    end
  end
end
