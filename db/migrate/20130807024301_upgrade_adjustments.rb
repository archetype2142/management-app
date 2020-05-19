class UpgradeAdjustments < ActiveRecord::Migration[4.2]
  def up
    # Add Temporary index
    add_index :adjustments, :originator_type unless index_exists?(:adjustments, :originator_type)

    # Temporarily make originator association available
    Adjustment.class_eval do
      belongs_to :originator, polymorphic: true
    end
    # Shipping adjustments are now tracked as fields on the object
    Adjustment.where(source_type: "Shipment").find_each do |adjustment|
      # Account for possible invalid data
      next if adjustment.source.nil?
      adjustment.source.update_column(:cost, adjustment.amount)
      adjustment.destroy!
    end

    # Tax adjustments have their sources altered
    Adjustment.where(originator_type: "TaxRate").find_each do |adjustment|
      adjustment.source_id = adjustment.originator_id
      adjustment.source_type = "TaxRate"
      adjustment.save!
    end

    # Promotion adjustments have their source altered also
    Adjustment.where(originator_type: "PromotionAction").find_each do |adjustment|
      next if adjustment.originator.nil?
      adjustment.source = adjustment.originator
      begin
        if adjustment.source.calculator_type == "Calculator::FreeShipping"
          # Previously this was a Promotion::Actions::CreateAdjustment
          # And it had a calculator to work out FreeShipping
          # In Spree 2.2, the "calculator" is now the action itself.
          adjustment.source.becomes(Promotion::Actions::FreeShipping)
        end
      rescue
        # Fail silently. This is primarily in instances where the calculator no longer exists
      end

      adjustment.save!
    end

    # Remove Temporary index
    remove_index :adjustments, :originator_type if index_exists?(:adjustments, :originator_type)
  end
end
