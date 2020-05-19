class RemoveSpreeConfigurations < ActiveRecord::Migration[4.2]
  def up
    drop_table "configurations"
  end

  def down
    create_table "configurations", force: true do |t|
      t.string   "name"
      t.string   "type",       limit: 50
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "configurations", ["name", "type"], name: "index_configurations_on_name_and_type"
  end
end
