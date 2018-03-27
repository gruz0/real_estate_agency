# == Schema Information
#
# Table name: addresses
#
#  id              :integer          not null, primary key
#  street_id       :integer          not null
#  building_number :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_addresses_on_building_number  (building_number)
#  index_addresses_on_street_id        (street_id)
#
# Foreign Keys
#
#  fk_rails_...  (street_id => streets.id)
#

class Address < ApplicationRecord
  audited

  scope :with_estates, -> { includes(:estate) }

  belongs_to :street
  has_many :estate, dependent: :restrict_with_error

  validates :building_number, presence: true, length: { minimum: 1 }

  delegate :name, to: :street, prefix: true

  def building_number=(value)
    super(value.try(:strip))
  end

  def full_name
    "#{street.city_name}, #{street_name}, #{building_number}"
  end
end
