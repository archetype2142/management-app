class AddTypeToReimbursementType < ActiveRecord::Migration[4.2]
  def change
    add_column :reimbursement_types, :type, :string
    add_index :reimbursement_types, :type

    ReimbursementType.reset_column_information
    ReimbursementType.find_by(name: ReimbursementType::ORIGINAL).update!(type: 'ReimbursementType::OriginalPayment')
  end
end
