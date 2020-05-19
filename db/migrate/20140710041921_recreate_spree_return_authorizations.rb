class RecreateSpreeReturnAuthorizations < ActiveRecord::Migration[4.2]
  def up
    # If the app has any legacy return authorizations then rename the table & columns and leave them there
    # for the legacy_return_authorizations extension to pick up with.
    # Otherwise just drop the tables/columns as they are no longer used in stock spree.  The legacy_return_authorizations
    # extension will recreate these tables for dev environments & etc as needed.
    if ReturnAuthorization.exists?
      rename_table :return_authorizations, :legacy_return_authorizations
      rename_column :inventory_units, :return_authorization_id, :legacy_return_authorization_id
    else
      drop_table :return_authorizations
      remove_column :inventory_units, :return_authorization_id
    end

    Adjustment.where(source_type: 'ReturnAuthorization').update_all(source_type: 'LegacyReturnAuthorization')

    # For now just recreate the table as it was.  Future changes to the schema (including dropping "amount") will be coming in a
    # separate commit.
    create_table :return_authorizations do |t|
      t.string   "number"
      t.string   "state"
      t.decimal  "amount", precision: 10, scale: 2, default: 0.0, null: false
      t.integer  "order_id"
      t.text     "reason"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "stock_location_id"
    end
  end
end
