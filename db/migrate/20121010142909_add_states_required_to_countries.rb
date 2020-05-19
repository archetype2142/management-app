class AddStatesRequiredToCountries < ActiveRecord::Migration[4.2]
  def change
    add_column :countries, :states_required, :boolean, default: true
  end
end
