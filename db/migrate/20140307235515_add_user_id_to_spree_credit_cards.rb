class AddUserIdToSpreeCreditCards < ActiveRecord::Migration[4.2]
  def change
    unless CreditCard.column_names.include? "user_id"
      add_column :credit_cards, :user_id, :integer
      add_index :credit_cards, :user_id
    end

    unless CreditCard.column_names.include? "payment_method_id"
      add_column :credit_cards, :payment_method_id, :integer
      add_index :credit_cards, :payment_method_id
    end
  end
end
