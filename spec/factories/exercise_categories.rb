FactoryBot.define do
  factory :exercise_category do
    sequence(:name) { |n| "Exercise Category #{n}" }
  end
end
