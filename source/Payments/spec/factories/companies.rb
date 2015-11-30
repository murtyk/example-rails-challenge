FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
    zip_code { Faker::Address.zip }
  end
end
