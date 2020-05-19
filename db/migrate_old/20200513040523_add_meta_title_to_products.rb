class AddMetaTitleToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :meta_title, :string
  end
end
