class AddStripePriceIdToPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :stripe_price_id, :string
  end
end
