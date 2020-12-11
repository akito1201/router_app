FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    outline { Faker::Lorem.sentence }
    city { '横浜市' }
    prefecture_id { 2 }
    member_id { 2 }

    association :user
  end
end
