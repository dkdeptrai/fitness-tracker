FactoryBot.define do
  factory :exercise_category do
    name { "Cardio" }
  end

  factory :muscle_group do
    sequence(:name) { |n| "Muscle Group #{n}" }
  end

  factory :user do
    email { Faker::Internet.email }
    password { "password" }
  end

  factory :exercise do
    name { "Push-up" }
    description { "Push-up description" }
    created_by_user { true }

    trait :with_single_muscle_group do
      muscle_groups { [association(:muscle_group)] } # Changed to array for single muscle group
    end

    trait :with_multiple_muscle_groups do
      muscle_groups { build_list(:muscle_group, 2) } # Properly associate multiple muscle groups
    end

    after(:build) do |exercise|
      exercise.user ||= build(:user)
      exercise.exercise_category ||= build(:exercise_category)
    end
  end
end
