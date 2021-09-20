class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    # @customer = current_customer
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
  end
  
  def confirm
  end
  
end
