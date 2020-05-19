class Shipment < ApplicationRecord
  with_options inverse_of: :shipments do
    belongs_to :address, class_name: 'Address'
    belongs_to :order, class_name: 'Order', touch: true
  end
  belongs_to :stock_location, class_name: 'StockLocation'

  with_options dependent: :delete_all do
    has_many :adjustments, as: :adjustable
    has_many :inventory_units, inverse_of: :shipment
    has_many :shipping_rates, -> { order(:cost) }
    has_many :state_changes, as: :stateful
  end
 
  has_many :shipping_methods, through: :shipping_rates
  has_one :selected_shipping_rate, -> { where(selected: true).order(:cost) }, class_name: ShippingRate.to_s

  # after_save :update_adjustments

  before_validation :set_cost_zero_when_nil

  validates :stock_location, presence: true
  validates :number, uniqueness: { case_sensitive: true }

  attr_accessor :special_instructions

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :inventory_units

  scope :pending, -> { with_state('pending') }
  scope :ready,   -> { with_state('ready') }
  scope :shipped, -> { with_state('shipped') }
  scope :trackable, -> { where("tracking IS NOT NULL AND tracking != ''") }
  scope :with_state, ->(*s) { where(state: s) }
  # sort by most recent shipped_at, falling back to created_at. add "id desc" to make specs that involve this scope more deterministic.
  scope :reverse_chronological, -> { order(Arel.sql('coalesce(spree_shipments.shipped_at, spree_shipments.created_at) desc'), id: :desc) }
  scope :valid, -> { where.not(state: :canceled) }

  # shipment state machine (see http://github.com/pluginaweek/state_machine/tree/master for details)
  # state_machine initial: :pending, use_transactions: false do
  #   event :ready do
  #     transition from: :pending, to: :ready, if: lambda { |shipment|
  #       # Fix for #2040
  #       shipment.determine_state(shipment.order) == 'ready'
  #     }
  #   end

  #   event :pend do
  #     transition from: :ready, to: :pending
  #   end

  #   event :ship do
  #     transition from: %i(ready canceled), to: :shipped
  #   end
  #   after_transition to: :shipped, do: :after_ship

  #   event :cancel do
  #     transition to: :canceled, from: %i(pending ready)
  #   end
  #   after_transition to: :canceled, do: :after_cancel

  #   event :resume do
  #     transition from: :canceled, to: :ready, if: lambda { |shipment|
  #       shipment.determine_state(shipment.order) == 'ready'
  #     }
  #     transition from: :canceled, to: :pending
  #   end
  #   after_transition from: :canceled, to: %i(pending ready shipped), do: :after_resume

  #   after_transition do |shipment, transition|
  #     shipment.state_changes.create!(
  #       previous_state: transition.from,
  #       next_state: transition.to,
  #       name: 'shipment'
  #     )
  #   end
  # end

  extend DisplayMoney
  money_methods :cost, :discounted_cost, :final_price, :item_cost
  
  alias display_amount display_cost

  def add_shipping_method(shipping_method, selected = false)
    shipping_rates.create(shipping_method: shipping_method, selected: selected, cost: cost)
  end

  def after_cancel
    manifest.each { |item| manifest_restock(item) }
  end

  def after_resume
    manifest.each { |item| manifest_unstock(item) }
  end

  def backordered?
    inventory_units.any?(&:backordered?)
  end

  def set_cost_zero_when_nil
    self.cost = 0 unless cost
  end

  # TODO: delegate currency to Order, order.currency is mandatory
  def currency
    order ? order.currency : Config[:currency]
  end

  # def recalculate_adjustments
    # Adjustable::AdjustmentsUpdater.update(self)
  # end

  # def update_adjustments
  #   recalculate_adjustments if saved_change_to_cost? && state != 'shipped'
  # end
end
