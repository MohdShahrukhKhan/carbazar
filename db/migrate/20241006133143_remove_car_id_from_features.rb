class RemoveCarIdFromFeatures < ActiveRecord::Migration[7.0]
  def change
    remove_column :features, :car_id, :integer
  end
end
