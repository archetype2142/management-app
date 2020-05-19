class PropertyPrototype < ApplicationRecord
  belongs_to :prototype, class_name: 'Prototype'
  belongs_to :property, class_name: 'Property'

  validates :prototype, :property, presence: true
  validates :prototype_id, uniqueness: { scope: :property_id }
end
