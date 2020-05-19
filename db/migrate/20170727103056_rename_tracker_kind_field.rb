class RenameTrackerKindField < ActiveRecord::Migration[5.1]
  def change
    rename_column :trackers, :kind, :engine
  end
end
