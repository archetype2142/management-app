class AddTimestampsToSpreeAssets < ActiveRecord::Migration[4.2]
  def change
    add_column :assets, :created_at, :datetime
    add_column :assets, :updated_at, :datetime
  end
end
