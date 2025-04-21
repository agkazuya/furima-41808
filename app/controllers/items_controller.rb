class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner!,      only: [:edit, :update, :destroy]
  before_action :ensure_not_sold!,   only: [:edit, :update]
  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品が投稿されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    return if @item.user_id == current_user.id

    redirect_to root_path
  end

  def show
  end

  def edit
    return if @item.user_id == current_user.id

    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: '商品情報が更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def ensure_owner!
    return if @item.user_id == current_user.id

    redirect_to root_path
  end

  def ensure_not_sold!
    return unless @item.sold?

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :condition_id, :category_id, :shipping_cost_id,
                                 :shipping_region_id, :shipping_time_id, :image).merge(user_id: current_user.id)
  end
end
