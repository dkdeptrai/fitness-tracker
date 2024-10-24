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
require 'rails_helper'

RSpec.describe Exercise, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
