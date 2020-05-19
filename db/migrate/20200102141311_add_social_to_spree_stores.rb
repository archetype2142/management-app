class AddSocialToSpreeStores < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :facebook, :string
    add_column :stores, :twitter, :string
    add_column :stores, :instagram, :string
  end
end
