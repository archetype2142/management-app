class RemoveTokenPermissionsTable < ActiveRecord::Migration[4.2]
  def change
    # The MoveOrderTokenFromTokenizedPermission migration never dropped this.
    drop_table :tokenized_permissions
  end
end
