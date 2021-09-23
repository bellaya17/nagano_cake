class Public::CartItemsController < ApplicationController
  
  def create
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id], customer_id: current_customer.id)
    if @cart_item.blank?
     @cart_item = CartItem.new(cart_items_params)
    end
    
    @cart_item.amount += params[:cart_item][:amount].to_i
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
  end
  
  
  def index
    @cart_items = current_customer.cart_items.all
    
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.amount = params[:cart_item][:id]
    @cart_item.update(cart_items_params)
    redirect_to 
  end
  
  def destroy
    @cart_items = CartItem.find(params[:id])
    cart_items.destroy
    redirect_to 
  end

  def destroy
    current_customer.cart_items.destroy_all
    redirect_to 
  end

  
  
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
