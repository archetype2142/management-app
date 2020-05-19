class OptionValueVariant < ApplicationRecord
  belongs_to :option_value, class_name: 'OptionValue'
  belongs_to :variant, class_name: 'Variant'

  validates :option_value, :variant, presence: true
  validates :option_value_id, uniqueness: { scope: :variant_id }
end
