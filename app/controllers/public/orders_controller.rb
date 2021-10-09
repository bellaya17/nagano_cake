class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @address = @customer.address
  end

  def confirm
    @order = Order.new(order_params)
    @customer = Customer.find(current_customer.id)
    @cart_items = current_customer.cart_items
      @delivery_fee = 800
      @total_price = 0
      @cart_items.each do |cart_item|
      @subtotal = cart_item.item.with_tax_price * cart_item.amount
      @total_price += cart_item.subtotal
      @total_payment = @total_price + @delivery_fee
      end

    if params[:order][:select_address] == "0"
      @customer = Customer.find(current_customer.id)
      @order.postal_code = @customer.postal_code
      @order.address = @customer.address
      @order.name = @customer.last_name + @customer.first_name

    elsif
      params[:order][:select_address] == "1"
      @customer = Customer.find(current_customer.id)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    elsif
      params[:order][:select_address] == "2"
      @address = Address.new(address_params)
      # binding.pry
      @order.customer_id = current_customer.id
      # @order.item_id = current_customer.item_id
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
      @address.customer_id = current_customer.id
      @address.save
    end
  end

  def create
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      @delivery_fee = 800
      @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = cart_item.item.price
      @order_detail.save
    end

    current_customer.cart_items.destroy_all
    redirect_to public_orders_thanks_path
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order.customer_id = current_customer.id
    @order_details = @order.order_details.all
    @delivery_fee = 800
    @total_price = 0
    @order_details.each do |order_detail|
    @subtotal = order_detail.item.with_tax_price * order_detail.amount
    @total_price += order_detail.subtotal
    @total_payment = @total_price + @delivery_fee
    end

  end

  def thanks
  end

  private

  def address_params

    params.require(:order).permit(:postal_code, :address, :name)

  end

  def order_params

    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)

  end


end
