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
    @customer.update(customer_params)
    redirect_to public_customer_path(@customer.id)
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
  end
  
  def withdraw
    @customer = Customer.find_by(params[:id])
    @customer.update(is_valid: false)
    reset_session
    redirect_to public_homes_top_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number)
  end
end
