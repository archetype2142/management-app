class StoreCreditType < ApplicationRecord
  DEFAULT_TYPE_NAME = 'Expiring'.freeze
  has_many :store_credits, class_name: 'StoreCredit', foreign_key: 'type_id'
end
