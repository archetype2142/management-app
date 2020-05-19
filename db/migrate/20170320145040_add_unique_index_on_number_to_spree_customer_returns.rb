class AddUniqueIndexOnNumberToSpreeCustomerReturns < ActiveRecord::Migration[5.0]
  def change
    unless index_exists?(:customer_returns, :number, unique: true)
      numbers = CustomerReturn.group(:number).having('sum(1) > 1').pluck(:number)
      returns = CustomerReturn.where(number: numbers)

      returns.find_each do |r|
        r.number = r.class.number_generator.method(:generate_permalink).call(r.class)
        r.save
      end

      remove_index :customer_returns, :number if index_exists?(:customer_returns, :number)
      add_index :customer_returns, :number, unique: true
    end
  end
end
