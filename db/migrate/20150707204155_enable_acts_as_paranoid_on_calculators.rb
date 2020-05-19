class EnableActsAsParanoidOnCalculators < ActiveRecord::Migration[4.2]
  def change
    add_column :calculators, :deleted_at, :datetime
    add_index :calculators, :deleted_at
  end
end
