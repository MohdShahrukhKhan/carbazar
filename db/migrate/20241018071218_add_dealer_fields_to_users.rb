class AddDealerFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :address, :string
    add_column :users, :brand, :string
    add_column :users, :mobile_number, :string
    add_column :users, :city, :string
  end
end
