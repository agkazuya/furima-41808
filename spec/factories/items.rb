FactoryBot.define do
  factory :item do
    name               { 'テスト' }
    description        { 'テストテスト' }
    condition_id       { 2 }
    category_id        { 11 }
    shipping_cost_id   { 3 }
    shipping_region_id { 3 }
    shipping_time_id   { 3 }
    price              { 1000 }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
