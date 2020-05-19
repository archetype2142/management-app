class AddTaxableAdjustmentTotalToLineItem < ActiveRecord::Migration[4.2]
  def change
    add_column :line_items, :taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false
    add_column :line_items, :non_taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false

    add_column :shipments, :taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false
    add_column :shipments, :non_taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false

    add_column :orders, :taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false
    add_column :orders, :non_taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false
    # TODO migration that updates old orders
  end
end
