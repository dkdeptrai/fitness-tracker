# == Schema Information
#
# Table name: muscle_groups
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MuscleGroup < ApplicationRecord
  has_and_belongs_to_many :exercises
end
