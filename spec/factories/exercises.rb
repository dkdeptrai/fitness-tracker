FactoryBot.define do
  factory :exercise do
    sequence(:name) { |n| "Exercise #{n}" }
    description { "Sample exercise description" }
    created_by_user { true }

    association :user
    association :exercise_category

    trait :with_multiple_muscle_groups do
      muscle_groups { build_list(:muscle_group, 2) }
    end

    trait :created_by_admin do
      created_by_user { false }
    end
  end
end
