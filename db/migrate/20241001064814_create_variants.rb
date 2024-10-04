class CreateVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :variants do |t|

      t.string :variant
      t.string :price
      t.string :colour
      t.integer :car_id


      t.timestamps
    end
  end
end
