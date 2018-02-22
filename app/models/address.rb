class Address < ApplicationRecord
  scope :with_estates, -> { includes(:estate) }

  belongs_to :street
  has_many :estate, dependent: :destroy

  validates :building_number, presence: true, length: { minimum: 1 }

  def building_number=(value)
    super(value.try(:strip))
  end

  def full_name
    "#{street.city_name}, #{street.name}, #{building_number}"
  end
end
