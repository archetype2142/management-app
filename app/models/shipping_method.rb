class ShippingMethod < ApplicationRecord
  DISPLAY = [:both, :front_end, :back_end]

  # Used for #refresh_rates
  DISPLAY_ON_FRONT_END = 1
  DISPLAY_ON_BACK_END = 2

  default_scope { where(deleted_at: nil) }

  has_many :shipping_method_categories, dependent: :destroy
  has_many :shipping_categories, through: :shipping_method_categories
  has_many :shipping_rates, inverse_of: :shipping_method
  has_many :shipments, through: :shipping_rates

  has_many :shipping_method_zones, class_name: 'ShippingMethodZone',
                                   foreign_key: 'shipping_method_id'

  belongs_to :tax_category, class_name: 'TaxCategory', optional: true

  validates :name, :display_on, presence: true

  validate :at_least_one_shipping_category

  def build_tracking_url(tracking)
    return if tracking.blank? || tracking_url.blank?

    tracking_url.gsub(/:tracking/, ERB::Util.url_encode(tracking))
  end

  def tax_category
    TaxCategory.unscoped { super }
  end

  private

  def at_least_one_shipping_category
    if shipping_categories.empty?
      errors.add(:base, :required_shipping_category)
    end
  end
end
