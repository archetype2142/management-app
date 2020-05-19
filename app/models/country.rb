class Country < ApplicationRecord
  # before_destroy :ensure_not_default
  has_many :addresses, dependent: :restrict_with_error
  has_many :states, dependent: :destroy

  validates :name, :iso_name, :iso, :iso3, presence: true, uniqueness: { case_sensitive: false }

  def self.default
    default = find_by(id: country_id) if country_id.present?
    default || find_by(iso: 'PL') || first
  end

  def to_s
    name
  end

  private

  def ensure_not_default
    if id.eql?(Config[:default_country_id])
      errors.add(:base, t(:default_country_cannot_be_deleted))
      throw(:abort)
    end
  end
end
