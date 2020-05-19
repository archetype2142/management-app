class RemoveUserIndexFromSpreeStateChanges < ActiveRecord::Migration[4.2]
  def up
    if index_exists? :state_changes, :user_id
      remove_index :state_changes, :user_id
    end

  end

  def down
    unless index_exists? :state_changes, :user_id
      add_index :state_changes, :user_id
    end
  end
end
