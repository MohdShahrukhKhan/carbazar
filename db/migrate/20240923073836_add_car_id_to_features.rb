class AddCarIdToFeatures < ActiveRecord::Migration[7.0]
  def change
    add_column :features, :car_id, :integer
  end
end
