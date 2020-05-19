class CreateConfig < ActiveRecord::Migration[6.0]
  def change
    create_table :configurations do |t|
      t.string     :name
      t.string     :type, limit: 50
      t.timestamps null: false, precision: 6
    end

    add_index :configurations, [:name, :type], name: 'index_configurations_on_name_and_type'
  end
end
