class AddUniqueIndexOnNumberToSpreeShipment < ActiveRecord::Migration[5.0]
  def change
    unless index_exists?(:shipments, :number, unique: true)
      numbers = Shipment.group(:number).having('sum(1) > 1').pluck(:number)
      shipments = Shipment.where(number: numbers)

      shipments.find_each do |shipment|
        shipment.number = shipment.class.number_generator.method(:generate_permalink).call(shipment.class)
        shipment.save
      end

      remove_index :shipments, :number if index_exists?(:shipments, :number)
      add_index :shipments, :number, unique: true
    end
  end
end
