class AddIncludedToAdjustments < ActiveRecord::Migration[4.2]
  def change
    add_column :adjustments, :included, :boolean, default: false unless Adjustment.column_names.include?("included")
  end
end
