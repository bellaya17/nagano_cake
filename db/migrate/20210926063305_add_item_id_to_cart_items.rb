class AddItemIdToCartItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_items, :item, foreign_key: true
  end
end
