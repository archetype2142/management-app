class Order < ApplicationRecord
  PAYMENT_STATES = %w(balance_due credit_owed failed paid void)
  SHIPMENT_STATES = %w(backorder canceled partial pending ready shipped)

  MONEY_THRESHOLD  = 100_000_000
  MONEY_VALIDATION = {
    presence: true,
    numericality: {
      greater_than: -MONEY_THRESHOLD,
      less_than: MONEY_THRESHOLD,
      allow_blank: true
    },
    format: { with: /\A-?\d+(?:\.\d{1,2})?\z/, allow_blank: true }
  }.freeze

  POSITIVE_MONEY_VALIDATION = MONEY_VALIDATION.deep_dup.tap do |validation|
    validation.fetch(:numericality)[:greater_than_or_equal_to] = 0
  end.freeze

  NEGATIVE_MONEY_VALIDATION = MONEY_VALIDATION.deep_dup.tap do |validation|
    validation.fetch(:numericality)[:less_than_or_equal_to] = 0
  end.freeze

  extend DisplayMoney
    money_methods :outstanding_balance, :item_total,           :adjustment_total,
                  :included_tax_total,  :additional_tax_total, :tax_total,
                  :shipment_total,      :promo_total,          :total,
                  :cart_promo_total

  attr_reader :coupon_code
  
  belongs_to :user, optional: true
  belongs_to :created_by, optional: true
  belongs_to :approver, optional: true
  belongs_to :canceler, optional: true

  belongs_to :bill_address, foreign_key: :bill_address_id, class_name: 'Address',
                              optional: true, dependent: :destroy
  alias_attribute :billing_address, :bill_address

  belongs_to :ship_address, foreign_key: :ship_address_id, class_name: 'Address',
                            optional: true, dependent: :destroy
  alias_attribute :shipping_address, :ship_address

  # belongs_to :store, class_name: 'Store'

  with_options dependent: :destroy do
    has_many :line_items, -> { order(:created_at) }, inverse_of: :order, class_name: 'LineItem'
    # has_many :payments, class_name: 'Payment'
  end
  # has_many :reimbursements, inverse_of: :order, class_name: 'Reimbursement'
  # has_many :line_item_adjustments, through: :line_items, source: :adjustments
  # has_many :inventory_units, inverse_of: :order, class_name: 'InventoryUnit'
  has_many :variants, through: :line_items
  has_many :products, through: :variants
  # has_many :refunds, through: :payments
  # has_many :all_adjustments,
  #          class_name: 'Adjustment',
  #          foreign_key: :order_id,
  #          dependent: :destroy,
  #          inverse_of: :order

  # has_many :order_promotions, class_name: 'OrderPromotion'
  # has_many :promotions, through: :order_promotions, class_name: 'Promotion'

  has_many :shipments, class_name: 'Shipment', dependent: :destroy, inverse_of: :order do
    def states
      pluck(:state).uniq
    end
  end
  # has_many :shipment_adjustments, through: :shipments, source: :adjustments

  accepts_nested_attributes_for :line_items
  accepts_nested_attributes_for :bill_address
  accepts_nested_attributes_for :ship_address
  # accepts_nested_attributes_for :payments, reject_if: :credit_card_nil_payment?
  accepts_nested_attributes_for :shipments

  # Needs to happen before save_permalink is called
  # before_validation :ensure_store_presence
  # before_validation :ensure_currency_presence
  # before_validation :clone_billing_address, if: :use_billing?
  attr_accessor :use_billing

  # before_create :create_token
  # before_create :link_by_email
  # before_update :homogenize_line_item_currencies, if: :currency_changed?

  with_options presence: true do
    validates :number, length: { maximum: 32, allow_blank: true }, uniqueness: { allow_blank: true, case_sensitive: false }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :require_email
    validates :item_count, numericality: { greater_than_or_equal_to: 0, less_than: 2**31, only_integer: true, allow_blank: true }
    # validates :store
    validates :currency
  end

  validates :payment_state,        inclusion:    { in: PAYMENT_STATES, allow_blank: true }
  validates :shipment_state,       inclusion:    { in: SHIPMENT_STATES, allow_blank: true }
  validates :item_total,           POSITIVE_MONEY_VALIDATION
  validates :adjustment_total,     MONEY_VALIDATION
  validates :included_tax_total,   POSITIVE_MONEY_VALIDATION
  validates :additional_tax_total, POSITIVE_MONEY_VALIDATION
  validates :payment_total,        MONEY_VALIDATION
  validates :shipment_total,       MONEY_VALIDATION
  validates :promo_total,          NEGATIVE_MONEY_VALIDATION
  validates :total,                MONEY_VALIDATION

  # delegate :update_totals, :persist_totals, to: :updater
  # delegate :merge!, to: :merger
  delegate :firstname, :lastname, to: :bill_address, prefix: true, allow_nil: true

  class_attribute :update_hooks
  self.update_hooks = Set.new

  scope :created_between, ->(start_date, end_date) { where(created_at: start_date..end_date) }
  scope :completed_between, ->(start_date, end_date) { where(completed_at: start_date..end_date) }
  scope :complete, -> { where.not(completed_at: nil) }
  scope :incomplete, -> { where(completed_at: nil) }

  # shows completed orders first, by their completed_at date, then uncompleted orders by their created_at
  scope :reverse_chronological, -> { order(Arel.sql('orders.completed_at IS NULL'), completed_at: :desc, created_at: :desc) }


  def associate_user!(user, override_email = true)
    self.user           = user
    self.email          = user.email if override_email
    self.created_by   ||= user
    self.bill_address ||= user.bill_address.try(:clone)
    self.ship_address ||= user.ship_address.try(:clone)

    changes = slice(:user_id, :email, :created_by_id, :bill_address_id, :ship_address_id)

    # immediately persist the changes we just made, but don't use save
    # since we might have an invalid address associated
    self.class.unscoped.where(id: self).update_all(changes)
  end

  def require_email
    true unless new_record?
  end
end
