class SplitPricesFromVariants < ActiveRecord::Migration[4.2]
  def up
    create_table :prices do |t|
      t.integer :variant_id, null: false
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.string :currency
    end

    Variant.all.each do |variant|
      Price.create!(
        variant_id: variant.id,
        amount: variant[:price],
        currency: Config[:currency]
      )
    end

    remove_column :variants, :price
  end

  def down
    prices = ApplicationRecord.connection.execute("select variant_id, amount from prices")
    add_column :variants, :price, :decimal, after: :sku, scale: 2, precision: 8

    prices.each do |price|
      ApplicationRecord.connection.execute("update variants set price = #{price['amount']} where id = #{price['variant_id']}")
    end
    
    change_column :variants, :price, :decimal, after: :sku, scale: 2, precision: 8, null: false
    drop_table :prices
  end
end
