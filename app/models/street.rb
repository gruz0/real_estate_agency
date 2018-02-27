class Street < ApplicationRecord
  belongs_to :city
  has_many :address, dependent: :restrict_with_error

  validates :name, presence: true, length: { minimum: 3 }
  validate :unique_in_city?

  delegate :name, to: :city, prefix: true

  def name=(value)
    super(value.try(:strip))
  end

  private

  def unique_in_city?
    cleaned_name = name.to_s.mb_chars.downcase

    return unless Street.exists?(city: city, name: cleaned_name)

    unless new_record?
      street = Street.find_by(city: city, name: cleaned_name)
      return if street.id == id
    end

    errors.add(:name, :taken)
  end
end
