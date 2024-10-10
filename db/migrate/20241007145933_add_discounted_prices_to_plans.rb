class AddDiscountedPricesToPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :discounted_price_monthly, :decimal
    add_column :plans, :discounted_price_yearly, :decimal
  end
end
