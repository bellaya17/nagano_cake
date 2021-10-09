class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all

    @delivery_fee = 800
    @subtotal = 0
    @total_price = 0
    @order_details.each do |order_detail|
      @subtotal = order_detail.item.with_tax_price * order_detail.amount
      @total_price += order_detail.subtotal
      @total_payment = @total_price + @delivery_fee
    end
  end


  def index
    @order = Order.find(params[:id])
  end


  def order_params
      params.require(:order).permit(:payment_method)
  end

end
