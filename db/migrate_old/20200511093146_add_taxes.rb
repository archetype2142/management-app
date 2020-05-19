class AddTaxes < ActiveRecord::Migration[6.0]
  def change
    create_table :tax_rates do |t|
      t.decimal    :amount,            precision: 8, scale: 5
      t.references :tax_category
      t.boolean    :included_in_price, default: false
      t.timestamps null: false,        precision: 6
    end
  end
end
