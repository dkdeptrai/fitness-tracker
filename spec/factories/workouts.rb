FactoryBot.define do
  factory :workout do
    begin_time { Time.now }
    calories { 100 }
    duration { 60 }
    association :profile

    trait :invalid do
      begin_time { nil }
    end
  end
end
