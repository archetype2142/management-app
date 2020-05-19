class AddDefaultLocaleToSpreeStore < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:stores, :default_locale)
      add_column :stores, :default_locale, :string
    end
  end
end
