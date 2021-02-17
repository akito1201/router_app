FactoryBot.define do
  factory :plan do
    place { Faker::Lorem.sentence }
    content { Faker::Lorem.sentence }
    association :post
  end
end
