require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  context '内容に問題ない場合' do
    it 'userとitemがあれば保存ができること' do
      expect(@order).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'userが紐付いていないと保存できないこと' do
      @order.user = nil
      @order.valid?
      expect(@order.errors.full_messages).to include('User must exist')
    end

    it 'itemが紐付いていないと保存できないこと' do
      @order.item = nil
      @order.valid?
      expect(@order.errors.full_messages).to include('Item must exist')
    end
  end
end
