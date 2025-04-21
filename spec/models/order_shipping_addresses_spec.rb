require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id)
  end

  context '内容に問題ない場合' do
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@order_shipping_address).to be_valid
    end
    it 'buildは空でも保存できること' do
      @order_shipping_address.build = ''
      expect(@order_shipping_address).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'postal_codeが空だと保存できないこと' do
      @order_shipping_address.postal_code = ''
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @order_shipping_address.postal_code = '1234567'
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include('Postal code is invalid')
    end
    it 'shipping_regionが---では保存できないこと' do
      @order_shipping_address.shipping_region_id = '1'
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include('Shipping region must be other than 1')
    end
    it 'address_cityが空だと保存できないこと' do
      @order_shipping_address.address_city = nil
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("Address city can't be blank")
    end
    it 'address_lineが空だと保存できないこと' do
      @order_shipping_address.address_line = nil
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("Address line can't be blank")
    end
    it 'phone_numberが空だと保存できないこと' do
      @order_shipping_address.phone_number = nil
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberが9桁以下だと保存できないこと' do
      @order_shipping_address.phone_number = '000134567'
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include('Phone number is invalid')
    end
    it 'phone_numberが数字以外だと保存できないこと' do
      @order_shipping_address.phone_number = '000-1234-1541'
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include('Phone number is invalid')
    end
    it 'userが紐付いていないと保存できないこと' do
      @order_shipping_address.user_id = nil
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
    end
    it 'token が空では保存できない' do
      @order_shipping_address.token = nil
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
    end
  end
end
