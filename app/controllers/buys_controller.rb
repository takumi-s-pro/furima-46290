class BuysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_invalid, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @buy_address = BuyAddress.new
  end

  def create
    @buy_address = BuyAddress.new(buy_address_params)
    
    if @buy_address.valid?
      pay_item
      @buy_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_invalid
    if current_user.id == @item.user_id || @item.buy.present?
      redirect_to root_path
    end
  end

  def buy_address_params
    params.require(:buy_address).permit(
      :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number
    ).merge(
      user_id: current_user.id, 
      item_id: params[:item_id], 
      token: params[:token]
    )
  end

  # 決済処理
  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] 
    Payjp::Charge.create(
      amount: @item.price,
      card: buy_address_params[:token],
      currency: 'jpy'
    )
  end
end