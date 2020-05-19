class CreateSpreeStoreCreditTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :store_credit_types do |t|
      t.string :name
      t.integer :priority
      t.timestamps null: false, precision: 6
    end
    add_index :store_credit_types, :priority
  end
end
