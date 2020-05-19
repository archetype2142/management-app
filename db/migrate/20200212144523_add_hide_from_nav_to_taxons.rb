class AddHideFromNavToTaxons < ActiveRecord::Migration[6.0]
  def change
    add_column :taxons, :hide_from_nav, :boolean, default: false, index: true
  end
end
