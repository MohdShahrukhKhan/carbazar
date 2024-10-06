class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :variant_id
      t.integer :status, default: 0          
      t.datetime :booking_date, null: false 

      t.timestamps
    end
  end
end
