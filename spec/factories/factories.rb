FactoryBot.define do
  factory :exercise_category do
    name { "Cardio" }
  end

  factory :muscle_group do
    sequence(:name) { |n| "Muscle Group #{n}" }
  end

  factory :user do
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "password" }
  end

  factory :exercise do
    name { "Push-up" }
    description { "Push-up description" }
    created_by_user { true }

    trait :with_single_muscle_group do
      muscle_groups { [build(:muscle_group)] }
    end

    trait :with_multiple_muscle_groups do
      muscle_groups { build_list(:muscle_group, 2) }
    end

    after(:build) do |exercise|
      exercise.user ||= build(:user)
      exercise.exercise_category ||= build(:exercise_category)
    end
  end
end
