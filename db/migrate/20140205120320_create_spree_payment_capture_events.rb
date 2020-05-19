class CreateSpreePaymentCaptureEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :payment_capture_events do |t|
      t.decimal :amount, precision: 10, scale: 2, default: 0.0
      t.integer :payment_id

      t.timestamps null: false, precision: 6
    end

    add_index :payment_capture_events, :payment_id
  end
end
