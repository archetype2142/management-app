class AddTimestampsToSpreePrices < ActiveRecord::Migration[5.2]
  def up
    add_timestamps :prices, default: Time.current
    change_column_default :prices, :created_at, nil
    change_column_default :prices, :updated_at, nil
  end

  def down
    remove_column :prices, :created_at
    remove_column :prices, :updated_at
  end
end
