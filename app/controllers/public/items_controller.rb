class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def item_params
    params.require(:item).permit(:name, :image_id, :introduction, :price )
  end
end


