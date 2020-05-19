class SpreePaymentMethodStoreCredits < ActiveRecord::Migration[4.2]
  def up
    # Reload to pick up new position column for acts_as_list
    PaymentMethod.reset_column_information
    PaymentMethod::StoreCredit.find_or_create_by(name: 'Store Credit', description: 'Store Credit',
                                                        active: true, display_on: 'back_end')
  end

  def down
    PaymentMethod.find_by(type: 'PaymentMethod::StoreCredit', name: 'Store Credit').try(&:destroy)
  end
end
