class AddCustomerIdToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :customer, foreign_key: true
  end
end
