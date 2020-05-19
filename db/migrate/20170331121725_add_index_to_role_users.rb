class AddIndexToRoleUsers < ActiveRecord::Migration[5.0]
  def change

    duplicates = RoleUser.group(:role_id, :user_id).having('sum(1) > 1').size

    duplicates.each do |f|
      role_id, user_id = f.first
      count = f.last - 1 # we want to leave one record
      roles = RoleUser.where(role_id: role_id, user_id: user_id).last(count)
      roles.map(&:destroy)
    end

    if index_exists? :role_users, [:role_id, :user_id]
      remove_index :role_users, [:role_id, :user_id]
      add_index :role_users, [:role_id, :user_id], unique: true
    end
  end
end
