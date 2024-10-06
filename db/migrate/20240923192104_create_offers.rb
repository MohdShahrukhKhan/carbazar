class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.string :offer_name
      t.decimal :discount
      t.date :start_date
      t.date :end_date
      t.integer :variant_id

      t.timestamps
    end
  end
end
