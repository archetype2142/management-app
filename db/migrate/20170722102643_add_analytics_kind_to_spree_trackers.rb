class AddAnalyticsKindToSpreeTrackers < ActiveRecord::Migration[5.1]
  def change
    add_column :trackers, :kind, :integer, default: 0, null: false, index: true
  end
end
