aclass CreateCars < ActiveRecord::Migration[7.0]
    def change
      create_table :cars do |t|
        t.string :name
        t.string :brand_id 
        t.string :body_type
        t.string :car_types
        t.date  :launch_date
      
  
        t.timestamps
      end
    end
  end
  