class RemoveCarIdFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :car_id, :integer
  end
end
