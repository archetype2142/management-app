class State < ApplicationRecord
  belongs_to :country, class_name: 'Country'
  has_many :addresses, dependent: :restrict_with_error

  validates :country, :name, presence: true
  validates :name, :abbr, uniqueness: { case_sensitive: false, scope: :country_id }, allow_blank: true

  def self.find_all_by_name_or_abbr(name_or_abbr)
    where('name = ? OR abbr = ?', name_or_abbr, name_or_abbr)
  end

  # table of { country.id => [ state.id , state.name ] }, arrays sorted by name
  # blank is added elsewhere, if needed
  def self.states_group_by_country_id
    state_info = Hash.new { |h, k| h[k] = [] }
    order(:name).each do |state|
      state_info[state.country_id.to_s].push [state.id, state.name]
    end
    state_info
  end

  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end
end