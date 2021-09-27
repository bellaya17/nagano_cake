class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @address = Address.new
    @customer = Customer.find(current_customer.id)
  end

  def create
    @customer = Customer.find(current_customer.id)
    @address = @customer.address.find(params[:regestrated_address][:regestrated_address])
    session[:payment_method] = order_params[:payment_method]
    if params[:select_address] == "radio1"
      session[:postal_code] = @customer.postal_code
      session[:address] = @customer.address
      session[:name] = @customer.last_name + @customer.first_name
      redirect_to public_orders_confirm_path
    elsif
       params[:select_address] == "radio2"
      session[:postal_code] = @address.postal_code
      session[:address] = @address.address
      session[:name] = @address.name
      redirect_to public_orders_confirm_path
    
    elsif params[:select_address] == "radio3"
      session[:postal_code] = order_params[:postal_code]
      session[:address] = order_params[:address]
      session[:name] = order_params[:name]
      @address = @customer.address.build
      @address.postal_code = order_params[:postal_code]
      @address.address = order_params[:address]
      @address.name = order_params[:name]
      @address.save
      redirect_to public_orders_confirm_path
    end
    
    if session[:select_address].present? && session[:payment_method].present?
      redirect_to public_orders_confirm_path
    else
      redirect_to new_public_order_path
    end
  end
  
  def confirm
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
      @order.delivery_fee = 800
      @order.total_payment =  + @order.delivery_fee
  end
  
  def create_order
      @order = Order.new(
        payment_method: session[:payment_method].to_i,
        name: session[:name],
        postal_code: session[:postal_code],
        address: session[:address],
        postage: 800,
        customer_id: customer.id
        )
      @order.customer_id = current_customer.id
      @order.payment_method = session[:payment_method]
      @order.address = session[:select_address]
      @order.total_payment =
      @order.save
      
    current_customer.cart_items.each do |cart|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_name = cart.item.name
      @order_detail.item_price = cart.item.price
      @order_detail.amount = cart.amount
      @order_detail.save
    end
    
    @order.current_customer.cart_items.destroy_all
    session[:payment_method].clear
    session[:name].clear
    session[:postal_code].clear
    session[:address].clear
    session.delete(:sum)
    redirect_to public_orders_thanks_path
  end
  
  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def thanks
  end
  
  private
  
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :delivery_fee, :total_payment, :payment_method )
  end

end
