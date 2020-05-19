class AddDeafultValueForStoreDefaultCurrency < ActiveRecord::Migration[6.0]
  def change
    Store.where(default_currency: nil).update_all(default_currency: 'PLN')
  end
end
