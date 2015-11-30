FactoryGirl.define do
  factory :charge do
    amount { Faker::Commerce.price }

    trait :successful do
      paid true
      refunded false
    end

    trait :disputed do
      paid true
      refunded true
    end

    trait :failed do
      paid false
    end

    factory :successful_charge, traits: [:successful]
    factory :disputed_charge,   traits: [:disputed]
    factory :failed_charge,     traits: [:failed]
  end
end
