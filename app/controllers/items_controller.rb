class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :check_editable, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @buy = Buy.new(buy_params)
    if @buy.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: params[:token],
        currency: 'jpy'
      )
      @buy.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id,
      :postage_id, :prefecture_id, :shipping_day_id, :price, :image
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def ensure_correct_user
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def check_editable
    if @item.buy.present? || current_user.id != @item.user_id
      redirect_to root_path
    end
  end

  def move_to_root
    redirect_to root_path if current_user.id == @item.user_id || @item.buy.present?
  end
end
