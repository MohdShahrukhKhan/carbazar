
class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :variant_id
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end