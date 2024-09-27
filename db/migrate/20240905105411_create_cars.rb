class CreateCars < ActiveRecord::Migration[7.0]
    def change
      create_table :cars do |t|
        t.string :name
        t.string :brand 
        t.string :body_type
        t.string :car_types
        t.date  :launch_date
        t.references :feature, foreign_key: true
  
        t.timestamps
      end
    end
  end
  