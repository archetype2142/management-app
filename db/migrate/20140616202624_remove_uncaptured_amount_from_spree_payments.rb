class RemoveUncapturedAmountFromSpreePayments < ActiveRecord::Migration[4.2]
  def change
    remove_column :payments, :uncaptured_amount
  end
end
