class Price < ApplicationRecord
  include VatPriceCalculation
  acts_as_paranoid

  # MAXIMUM_AMOUNT = BigDecimal('99_999_999.99')

  belongs_to :variant, class_name: 'Variant', inverse_of: :prices, touch: true

  before_validation :ensure_currency

  # validates :amount, allow_nil: true, numericality: {
  #   greater_than_or_equal_to: 0,
  #   less_than_or_equal_to: MAXIMUM_AMOUNT
  # }

  extend DisplayMoney
  money_methods :amount, :price

  # self.whitelisted_ransackable_attributes = ['amount']

  def money
    Money.new(amount || 0, currency: currency)
  end

  def amount=(amount)
    self[:amount] = localize_num_parse(amount)
  end

  alias_attribute :price, :amount

  def price_including_vat_for(price_options)
    options = price_options.merge(tax_category: variant.tax_category)
    gross_amount(price, options)
  end

  def display_price_including_vat_for(price_options)
    Money.new(price_including_vat_for(price_options), self.currency)
  end

  # Remove variant default_scope `deleted_at: nil`
  def variant
    Variant.unscoped { super }
  end

  private

  def ensure_currency
    self.currency ||= 'PLN'
  end

  def localize_num_parse(number)
    return number unless number.is_a?(String)

    separator, delimiter = I18n.t([:'number.currency.format.separator', :'number.currency.format.delimiter'])
    non_number_characters = /[^0-9\-#{separator}]/

    # work on a copy, prevent original argument modification
    number = number.dup
    # strip everything else first, including thousands delimiter
    number.gsub!(non_number_characters, '')
    # then replace the locale-specific decimal separator with the standard separator if necessary
    number.gsub!(separator, '.') unless separator == '.'

    # Returns 0 to avoid ArgumentError: invalid value for BigDecimal(): "" for empty string
    return 0 unless number.present?

    number.to_d
  end
end
