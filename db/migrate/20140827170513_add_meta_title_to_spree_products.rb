class AddMetaTitleToSpreeProducts < ActiveRecord::Migration[4.2]
  def change
    change_table :products do |t|
      t.string   :meta_title
    end
  end
end
