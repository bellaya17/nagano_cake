class AddItemIdToOrderDetails < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_details, :item, foreign_key: true
  end
end
