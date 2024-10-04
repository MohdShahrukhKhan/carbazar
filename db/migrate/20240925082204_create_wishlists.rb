class CreateWishlists < ActiveRecord::Migration[7.0]
  def change
    create_table :wishlists do |t|
      t.integer :user_id
      t.integer :car_id
      t.integer :variant_id
      t.timestamps
    end
  end
end
