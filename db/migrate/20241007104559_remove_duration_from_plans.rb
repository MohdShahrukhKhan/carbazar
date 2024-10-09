class RemoveDurationFromPlans < ActiveRecord::Migration[7.0]
  def change
    remove_column :plans, :duration, :integer
  end
end
