class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to @item
    else
      render :new
    end
  end

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id,
      :postage_id, :prefecture_id, :shipping_day_id, :price, :image
    ).merge(user_id: current_user.id, image: params[:item][:image])
  end
end