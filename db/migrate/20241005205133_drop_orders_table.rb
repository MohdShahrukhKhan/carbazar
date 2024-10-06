class DropOrdersTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :orders
  end

  def down
    # Optional: You can recreate the table here in case of rollback
    create_table :orders do |t|
      t.integer :user_id
      t.integer :total_price
      t.integer :status
      t.timestamps
    end
  end
end
