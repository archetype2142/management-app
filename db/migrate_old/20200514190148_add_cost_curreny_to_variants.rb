class AddCostCurrenyToVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :cost_currency, :string, after: :cost_price
  end
end
