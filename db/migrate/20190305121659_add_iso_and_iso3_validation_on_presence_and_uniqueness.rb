class AddIsoAndIso3ValidationOnPresenceAndUniqueness < ActiveRecord::Migration[5.2]
  def up
    Country.where.not(id: Country.group(:iso).select("min(id)")).destroy_all
    Country.where.not(id: Country.group(:iso3).select("min(id)")).destroy_all

    change_column_null(:countries, :iso, false)
    change_column_null(:countries, :iso3, false)
    add_index :countries, :iso, unique: true
    add_index :countries, :iso3, unique: true
  end

  def down
    change_column_null(:countries, :iso, true)
    change_column_null(:countries, :iso3, true)
    remove_index :countries, :iso, unique: true
    remove_index :countries, :iso3, unique: true
  end
end
