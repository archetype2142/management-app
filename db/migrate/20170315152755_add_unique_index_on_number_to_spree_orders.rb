class AddUniqueIndexOnNumberToSpreeOrders < ActiveRecord::Migration[5.0]
  def change
    unless index_exists?(:orders, :number, unique: true)
      numbers = Order.group(:number).having('sum(1) > 1').pluck(:number)
      orders = Order.where(number: numbers)

      orders.find_each do |order|
        order.number = order.class.number_generator.method(:generate_permalink).call(order.class)
        order.save
      end

      remove_index :orders, :number if index_exists?(:orders, :number)
      add_index :orders, :number, unique: true
    end
  end
end
