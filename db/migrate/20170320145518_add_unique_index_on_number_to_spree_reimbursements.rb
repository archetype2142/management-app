class AddUniqueIndexOnNumberToSpreeReimbursements < ActiveRecord::Migration[5.0]
  def change
    # unless index_exists?(:reimbursements, :number, unique: true)
    #   numbers = Reimbursement.group(:number).having('sum(1) > 1').pluck(:number)
    #   reimbursements = Reimbursement.where(number: numbers)

    #   reimbursements.find_each do |reimbursement|
    #     reimbursement.number = reimbursement.class.number_generator.method(:generate_permalink).call(reimbursement.class)
    #     reimbursement.save
    #   end

    #   remove_index :reimbursements, :number if index_exists?(:reimbursements, :number)
    #   add_index :reimbursements, :number, unique: true
    # end
  end
end
