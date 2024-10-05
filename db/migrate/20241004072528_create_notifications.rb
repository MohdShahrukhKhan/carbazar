class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :booking_id
      t.text :message, null: false
      t.boolean :read, default: false
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }

      
    end
  end
end
