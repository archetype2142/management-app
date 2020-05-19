class AddDeletedAtToSpreePrices < ActiveRecord::Migration[4.2]
  def change
    add_column :prices, :deleted_at, :datetime
  end
end
