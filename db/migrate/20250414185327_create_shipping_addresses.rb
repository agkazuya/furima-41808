class CreateShippingAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_addresses do |t|
      t.references :order,           null: false,foreign_key: true
      t.string :postal_code,         null: false
      t.integer :shipping_region_id, null: false
      t.string :address_city,        null: false
      t.string :address_line,        null: false
      t.string :build
      t.string :phone_number,        null: false

      t.timestamps
    end
  end
end
