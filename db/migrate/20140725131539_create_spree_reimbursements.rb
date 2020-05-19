class CreateSpreeReimbursements < ActiveRecord::Migration[4.2]
  def change
    create_table :reimbursements do |t|
      t.string :number
      t.string :reimbursement_status
      t.integer :customer_return_id
      t.integer :order_id
      t.decimal :total, precision: 10, scale: 2

      t.timestamps null: false, precision: 6
    end

    add_index :reimbursements, :customer_return_id
    add_index :reimbursements, :order_id

    remove_column :refunds, :customer_return_id, :integer
    add_column :refunds, :reimbursement_id, :integer

    add_column :return_items, :reimbursement_id, :integer
  end
end
