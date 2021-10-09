class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
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
     @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    if @customer.update(is_active: false)
      sign_out current_customer
    end
    redirect_to public_root_path
  end




  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_active )
  end

end
