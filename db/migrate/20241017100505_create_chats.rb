class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.integer :customer_id
      t.integer :dealer_id

      t.timestamps
    end
  end
end
