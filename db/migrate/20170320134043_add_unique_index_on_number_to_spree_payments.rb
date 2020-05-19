class AddUniqueIndexOnNumberToSpreePayments < ActiveRecord::Migration[5.0]
  def change
    unless index_exists?(:payments, :number, unique: true)
      # default scope in Payment disturbs Postgres, hence `unscoped` is needed.
      numbers = Payment.unscoped.group(:number).having('sum(1) > 1').pluck(:number)
      payments = Payment.where(number: numbers)

      payments.find_each do |payment|
        payment.number = payment.class.number_generator.method(:generate_permalink).call(payment.class)
        payment.save
      end

      remove_index :payments, :number if index_exists?(:payments, :number)
      add_index :payments, :number, unique: true
    end
  end
end
