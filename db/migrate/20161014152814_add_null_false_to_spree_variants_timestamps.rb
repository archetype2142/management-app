class AddNullFalseToSpreeVariantsTimestamps < ActiveRecord::Migration[5.0]
  def change
    change_column_null :variants, :created_at, false
    change_column_null :variants, :updated_at, false
  end
end
