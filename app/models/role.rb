class Role < ApplicationRecord
  has_many :role_users, class_name: 'RoleUser', dependent: :destroy
  has_many :users, through: :role_users, class_name: 'User'

  validates :name, presence: true, uniqueness: { case_sensitive: false, allow_blank: true }
end
