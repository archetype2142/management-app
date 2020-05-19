class SpreeStoreCreditTypes < ActiveRecord::Migration[4.2]
  def up
    StoreCreditType.find_or_create_by(name: 'Expiring', priority: 1)
    StoreCreditType.find_or_create_by(name: 'Non-expiring', priority: 2)
  end

  def down
    StoreCreditType.find_by(name: 'Expiring').try(&:destroy)
    StoreCreditType.find_by(name: 'Non-expiring').try(&:destroy)
  end
end
