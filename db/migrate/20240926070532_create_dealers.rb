class CreateDealers < ActiveRecord::Migration[7.0]
  def change
    create_table :dealers do |t|
      t.string :name
      t.integer :brand_id
      t.string :city
      t.string :address
      t.string :contact_number


      t.timestamps
    end
  end
end
