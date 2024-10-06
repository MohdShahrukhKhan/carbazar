class AddColumnToVariants < ActiveRecord::Migration[7.0]
  def change
    add_column :variants, :quantity, :integer
  end
end
