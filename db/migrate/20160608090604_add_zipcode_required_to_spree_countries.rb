class AddZipcodeRequiredToSpreeCountries < ActiveRecord::Migration[4.2]
  def change
    add_column :countries, :zipcode_required, :boolean, default: true
    Country.reset_column_information
    Country.where(iso: Address::NO_ZIPCODE_ISO_CODES).update_all(zipcode_required: false)
  end
end
