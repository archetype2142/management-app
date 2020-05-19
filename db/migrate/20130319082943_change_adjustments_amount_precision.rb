class ChangeAdjustmentsAmountPrecision < ActiveRecord::Migration[4.2]
  def change
   
    change_column :adjustments, :amount,  :decimal, precision: 10, scale: 2
                                   
  end
end
