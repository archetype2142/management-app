class AddPreferenceStoreToEverything < ActiveRecord::Migration[4.2]
  def change
    add_column :calculators, :preferences, :text
    add_column :gateways, :preferences, :text
    add_column :payment_methods, :preferences, :text
    add_column :promotion_rules, :preferences, :text
  end
end
