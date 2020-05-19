class User < ApplicationRecord
  include UserAddress
  before_validation :set_provider
  # before_validation :set_uid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  include DeviseTokenAuth::Concerns::ActiveRecordSupport
  include DeviseTokenAuth::Concerns::User
  
  attr_accessor :use_billing

  before_validation :clone_billing_address, if: :use_billing?

  has_many :orders, foreign_key: :user_id, class_name: 'Order'
  
  has_many :role_users, class_name: 'RoleUser', foreign_key: :user_id, dependent: :destroy
  has_many :roles, through: :role_users, class_name: 'Role', source: :role

  belongs_to :ship_address, class_name: 'Address', optional: true
  belongs_to :bill_address, class_name: 'Address', optional: true

  private

  # def check_completed_orders
  #   raise Core::DestroyWithOrdersError if orders.complete.present?
  # end

  def nullify_approver_id_in_approved_orders
    Order.where(approver_id: id).update_all(approver_id: nil)
  end

  def clone_billing_address
    if bill_address && ship_address.nil?
      self.ship_address = bill_address.clone
    else
      ship_address.attributes = bill_address.attributes.except('id', 'updated_at', 'created_at')
    end
    true
  end

  def use_billing?
    use_billing.in?([true, 'true', '1'])
  end

  def set_provider
    self[:provider] = "email" if self[:provider].blank?
  end

  def set_uid
    self[:uid] = self[:email] if self[:uid].blank? && self[:email].present?
  end
end
