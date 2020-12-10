FactoryBot.define do
  factory :plan do
    place {Faker::Lorem.sentence}
    text { Faker::Lorem.sentence }
    association :post

    after(:build) do |plan|
      plan.image.attach(io: File.open('public/test_image.png'), filename: 'test_image.png')
    end
  end
end
