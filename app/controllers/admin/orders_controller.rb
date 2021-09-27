class Admin::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    
    # 合計金額を求めるメソッドを記述
    
  end


  def index
    
end
