class AddDeletedAtToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :deleted_at, :timestamp
  end
end
