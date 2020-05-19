class AddNumberToStockTransfer < ActiveRecord::Migration[4.2]
  def up
    remove_index :stock_transfers, :source_location_id
    remove_index :stock_transfers, :destination_location_id

    rename_column :stock_transfers, :reference_number, :reference
    add_column :stock_transfers, :number, :string

    StockTransfer.find_each do |transfer|
      transfer.send(:generate_stock_transfer_number)
      transfer.save!
    end

    add_index :stock_transfers, :number
    add_index :stock_transfers, :source_location_id
    add_index :stock_transfers, :destination_location_id
  end

  def down
    rename_column :stock_transfers, :reference, :reference_number
    remove_column :stock_transfers, :number, :string
  end
end
