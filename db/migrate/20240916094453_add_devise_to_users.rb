class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  def self.up
    change_table :users do |t|
      # Don't add the email column since it already exists
      # t.string :email, null: false, default: ""

      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.index :reset_password_token, unique: true
    end
  end

  def self.down
    remove_columns :users, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  end
end
