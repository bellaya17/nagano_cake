class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def customer_params
    params.require(:item).permit(:name, :image_id, :introduction, :price )
  end
end


