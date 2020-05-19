class AddAdditionalStoreFields < ActiveRecord::Migration[4.2]
  def change
    add_column :stores, :code, :string unless column_exists?(:stores, :code)
    add_column :stores, :default, :boolean, default: false, null: false unless column_exists?(:stores, :default)
    add_index :stores, :code
    add_index :stores, :default
  end
end
