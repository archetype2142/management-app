class AddCodeToSpreePromotionRules < ActiveRecord::Migration[4.2]
  def change
    add_column :promotion_rules, :code, :string
  end
end
