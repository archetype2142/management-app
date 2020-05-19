class AddAddressFieldsToStockLocation < ActiveRecord::Migration[4.2]
  def change
    remove_column :stock_locations, :address_id

    add_column :stock_locations, :address1, :string
    add_column :stock_locations, :address2, :string
    add_column :stock_locations, :city, :string
    add_column :stock_locations, :state_id, :integer
    add_column :stock_locations, :state_name, :string
    add_column :stock_locations, :country_id, :integer
    add_column :stock_locations, :zipcode, :string
    add_column :stock_locations, :phone, :string


    usa = Country.where(iso: 'US').first
    # In case USA isn't found.
    # See #3115
    country = usa || Country.first
    Country.reset_column_information
    StockLocation.update_all(country_id: country)
  end
end
