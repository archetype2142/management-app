class CreateSpreeStoreCreditEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :store_credit_events do |t|
      t.integer  :store_credit_id,    null: false
      t.string   :action,             null: false
      t.decimal  :amount,             precision: 8,  scale: 2
      t.string   :authorization_code, null: false
      t.decimal  :user_total_amount,  precision: 8, scale: 2, default: 0.0, null: false
      t.integer  :originator_id
      t.string   :originator_type
      t.datetime :deleted_at
      t.timestamps null: false, precision: 6
    end
    add_index :store_credit_events, :store_credit_id
    add_index :store_credit_events, [:originator_id, :originator_type], name: :store_credit_events_originator
  end
end
