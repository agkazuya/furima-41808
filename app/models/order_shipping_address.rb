class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :shipping_region_id, :address_city, :address_line, :build, :phone_number,
                :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :shipping_region_id, numericality: { only_integer: true, other_than: 1 }
    validates :address_city
    validates :address_line
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :item_id
    validates :user_id
    validates :token
  end

  def save
    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)

      ShippingAddress.create!(
        order_id: order.id,
        postal_code: postal_code,
        shipping_region_id: shipping_region_id,
        address_city: address_city,
        address_line: address_line,
        build: build,
        phone_number: phone_number
      )
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
end
