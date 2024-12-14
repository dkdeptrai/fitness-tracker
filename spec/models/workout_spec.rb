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
  let(:profile) { create(:profile) }

  context 'validations' do
    it 'is valid with valid attributes' do
      workout = build(:workout, profile: profile)
      expect(workout).to be_valid
    end

    it 'is invalid without a begin time' do
      workout = build(:workout, :invalid, profile: profile)
      expect(workout).to be_invalid
      expect(workout.errors[:begin_time]).to include("can't be blank")
    end

    it 'is invalid with negative duration' do
      workout = build(:workout, duration: -10, profile: profile)
      expect(workout).to be_invalid
      expect(workout.errors[:duration]).to include("must be greater than or equal to 0")
    end
  end

  context 'callbacks' do
    it 'sets name to begin_time if name is blank before saving' do
      workout = build(:workout, name: nil, profile: profile, begin_time: Time.zone.local(2024, 1, 1, 15, 0, 0))
      workout.save
      expect(workout.name).to eq("2024-01-01 15:00:00")
    end
  end


  context 'methods' do
    describe '#complete_workout' do
      it 'sets end_time and calculates duration' do
        workout = create(:workout, profile: profile, begin_time: Time.now)
        travel_to(Time.now + 2.hours) do
          workout.send(:complete_workout)
          expect(workout.end_time).not_to be_nil
          expect(workout.duration).to eq(7200)
        end
      end
    end
  end
end
