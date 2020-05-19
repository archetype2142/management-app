class DropReturnAuthorizationAmount < ActiveRecord::Migration[4.2]
  def change
    remove_column :return_authorizations, :amount
  end
end
