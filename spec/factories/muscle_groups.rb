FactoryBot.define do
  factory :muscle_group do
    sequence(:name) { |n| "Muscle Group #{n}" }
  end
end

