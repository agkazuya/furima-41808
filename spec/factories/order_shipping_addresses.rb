FactoryBot.define do
  factory :order_shipping_address do
    postal_code { '123-4567' }
    shipping_region_id { 2 }
    address_city { '東京都' }
    address_line { '青山1-1-1' }
    build { '青山ハイツ' }
    phone_number { '00012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
