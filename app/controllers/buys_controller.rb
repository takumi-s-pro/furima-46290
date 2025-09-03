class BuysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root, only: [:index, :create]

  def index
    @buy = Buy.new
  end

  def create
    @buy = Buy.new(user_id: current_user.id, item_id: @item.id)
    if @buy.save
      redirect_to root_path, notice: "購入が完了しました"
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    if current_user.id == @item.user_id || @item.buy.present?
      redirect_to root_path
    end
  end
end