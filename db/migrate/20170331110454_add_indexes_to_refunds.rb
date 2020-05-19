class AddIndexesToRefunds < ActiveRecord::Migration[5.0]
  def change
    add_index :refunds, :payment_id
    add_index :refunds, :reimbursement_id
  end
end
