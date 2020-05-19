class AddIndexToShippingMethodZones < ActiveRecord::Migration[5.0]
  def change
    duplicates = ShippingMethodZone.group(:shipping_method_id, :zone_id).having('sum(1) > 1').size

    duplicates.each do |f|
      shipping_method_id, zone_id = f.first
      count = f.last - 1 # we want to leave one record
      zones = ShippingMethodZone.where(shipping_method_id: shipping_method_id, zone_id: zone_id).last(count)
      zones.map(&:destroy)
    end

    if index_exists? :shipping_method_zones, [:shipping_method_id, :zone_id]
      remove_index :shipping_method_zones, [:shipping_method_id, :zone_id]
      add_index :shipping_method_zones, [:shipping_method_id, :zone_id], unique: true
    end

    add_index :shipping_method_zones, :zone_id
    add_index :shipping_method_zones, :shipping_method_id
  end
end
