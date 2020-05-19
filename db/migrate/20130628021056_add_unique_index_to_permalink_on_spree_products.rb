class AddUniqueIndexToPermalinkOnSpreeProducts < ActiveRecord::Migration[4.2]
  def change
    add_index "products", ["permalink"], name: "permalink_idx_unique", unique: true
  end
end
