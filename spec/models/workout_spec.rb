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
require 'rails_helper'

RSpec.describe Workout, type: :model do
  fixtures :workouts

  before do
    @valid_workout = workouts(:valid_workout)
  end

  it "requires a begin time" do
    workout = Workout.new(name: "invalid workout",begin_time: nil, end_time: nil)
    expect(workout).not_to be_valid
    expect(workout.errors[:begin_time]).to include("can't be blank")

    workout = @valid_workout
    expect(workout).to be_valid
  end

  it "name defaults to begin time" do
    workout = Workout.new(begin_time: Time.now, end_time: Time.now + 1.hour)
    workout.save
    expect(workout).to be_valid
    expect(workout.name).to eq(workout.begin_time.strftime("%Y-%m-%d %H:%M:%S"))
  end

  it "duration is calculated correctly" do
    workout = Workout.new(begin_time: Time.now, end_time: Time.now + 1.hour)
    workout.save
    expect(workout.duration).to eq(1.hour)
  end
end
