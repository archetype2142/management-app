class Address < ApplicationRecord
  NO_ZIPCODE_ISO_CODES ||= [
    'AO', 'AG', 'AW', 'BS', 'BZ', 'BJ', 'BM', 'BO', 'BW', 'BF', 'BI', 'CM', 'CF', 'KM', 'CG',
    'CD', 'CK', 'CUW', 'CI', 'DJ', 'DM', 'GQ', 'ER', 'FJ', 'TF', 'GAB', 'GM', 'GH', 'GD', 'GN',
    'GY', 'HK', 'IE', 'KI', 'KP', 'LY', 'MO', 'MW', 'ML', 'MR', 'NR', 'AN', 'NU', 'KP', 'PA',
    'QA', 'RW', 'KN', 'LC', 'ST', 'SC', 'SL', 'SB', 'SO', 'SR', 'SY', 'TZ', 'TL', 'TK', 'TG',
    'TO', 'TV', 'UG', 'AE', 'VU', 'YE', 'ZW'
  ].freeze

  # we're not freezing this on purpose so developers can extend and manage
  # those attributes depending of the logic of their applications
  ADDRESS_FIELDS = %w(firstname lastname company address1 address2 city state zipcode country phone)
  EXCLUDED_KEYS_FOR_COMPARISION = %w(id updated_at created_at deleted_at user_id)

  belongs_to :country, class_name: 'Country'
  belongs_to :state, class_name: 'State', optional: true
  belongs_to :user, class_name: 'User', optional: true

  has_many :shipments, inverse_of: :address

  with_options presence: true do
    validates :firstname, :lastname, :address1, :city, :country
    # validates :zipcode, if: :require_zipcode?
    # validates :phone, if: :require_phone?
  end

  # validate :state_validate, :postal_code_validate

  delegate :name, :iso3, :iso, :iso_name, to: :country, prefix: true
  delegate :abbr, to: :state, prefix: true, allow_nil: true

  alias_attribute :first_name, :firstname
  alias_attribute :last_name, :lastname
end
