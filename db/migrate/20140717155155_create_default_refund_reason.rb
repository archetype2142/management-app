class CreateDefaultRefundReason < ActiveRecord::Migration[4.2]
  def up
    RefundReason.create!(name: RefundReason::RETURN_PROCESSING_REASON, mutable: false)
  end
end
