class AddBrandIdToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :brand_id, :integer
  end
end
