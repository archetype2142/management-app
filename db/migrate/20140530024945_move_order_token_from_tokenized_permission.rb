class MoveOrderTokenFromTokenizedPermission < ActiveRecord::Migration[4.2]
  def up
    case Order.connection.adapter_name
    when 'SQLite'
      Order.has_one :tokenized_permission, as: :permissable
      Order.includes(:tokenized_permission).each do |o|
        o.update_column :guest_token, o.tokenized_permission.token
      end
    when 'Mysql2', 'MySQL'
      execute "UPDATE orders, tokenized_permissions
               SET orders.guest_token = tokenized_permissions.token
               WHERE tokenized_permissions.permissable_id = orders.id
                  AND tokenized_permissions.permissable_type = 'Order'"
    else
      execute "UPDATE orders
               SET guest_token = tokenized_permissions.token
               FROM tokenized_permissions
               WHERE tokenized_permissions.permissable_id = orders.id
                  AND tokenized_permissions.permissable_type = 'Order'"
    end
  end
end
