class CreateProductProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :product_properties do |t|
      t.string     :value
      t.references :product
      t.references :property
      t.integer :position, default: 0
      t.timestamps null: false, precision: 6
    end
  end
end

