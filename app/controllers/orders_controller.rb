class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :ensure_purchasable, only: [:new, :create]

  def index
    @orders = @item.orders
  end

  def new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_shipping_address = OrderShippingAddress.new
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_params)
    if @order_shipping_address.valid?
      pay_item
      @order_shipping_address.save
      redirect_to root_path, notice: '注文が正常に完了しました。'
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def ensure_purchasable
    if @item.user_id == current_user.id
      redirect_to root_path
    elsif @item.sold?
      redirect_to root_path
    end
  end

  def order_params
    params.require(:order_shipping_address).permit(:postal_code, :shipping_region_id, :address_city, :address_line, :build,
                                                   :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
