class AddNameToSpreeCreditCards < ActiveRecord::Migration[4.2]
  def change
    add_column :credit_cards, :name, :string
  end
end
