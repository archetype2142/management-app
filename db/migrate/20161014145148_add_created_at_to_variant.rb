class AddCreatedAtToVariant < ActiveRecord::Migration[5.0]
  def change
    add_column :variants, :created_at, :datetime
    Variant.reset_column_information
    Variant.unscoped.where.not(updated_at: nil).update_all('created_at = updated_at')
    Variant.unscoped.where(updated_at: nil).update_all(created_at: Time.current, updated_at: Time.current)
  end
end
