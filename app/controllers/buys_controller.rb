class BuysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root, only: [:index, :create]

  def index
    @buy = Buy.new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
    @buy = Buy.new(buy_params)
    if @buy.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @item.price,      
        card: params[:token],
        currency: 'jpy'
      )
      @buy.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def buy_params
  params.require(:buy).permit(
    address_attributes: [:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number]
  ).merge(user_id: current_user.id, item_id: @item.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    if current_user.id == @item.user_id || @item.buy.present?
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: buy_params[:token],
      currency: 'jpy'
    )
  end
end