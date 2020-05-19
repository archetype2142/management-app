class RemoveEnvironmentFromTracker < ActiveRecord::Migration[4.2]
  def up
    # Tracker.where('environment != ?', Rails.env).update_all(active: false)
    # remove_column :trackers, :environment
  end
end
