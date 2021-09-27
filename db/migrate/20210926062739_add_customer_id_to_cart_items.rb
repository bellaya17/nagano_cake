class AddCustomerIdToCartItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_items, :customer, foreign_key: true
  end
end
