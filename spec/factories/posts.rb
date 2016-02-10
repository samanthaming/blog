FactoryGirl.define do
  factory :post do

    sequence(:title)  {|n| "#{Faker::Lorem.characters(10)}-#{n}"}
    body              Faker::Lorem.paragraph

  end
end
