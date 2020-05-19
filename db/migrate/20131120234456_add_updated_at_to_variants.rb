class AddUpdatedAtToVariants < ActiveRecord::Migration[4.2]
  def change
    add_column :variants, :updated_at, :datetime
  end
end
