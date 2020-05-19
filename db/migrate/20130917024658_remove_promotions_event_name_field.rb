class RemovePromotionsEventNameField < ActiveRecord::Migration[4.2]
  def change
    remove_column :promotions, :event_name, :string
  end
end
