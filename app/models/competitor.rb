class Competitor < ApplicationRecord
  audited

  PHONE_NUMBERS_REGEX = /\A[+\d]+\z/

  validates :phone_numbers, presence: true, length: { minimum: 6 }
  validate :phone_numbers_valid?

  before_save :clear_phone_numbers

  def name=(value)
    new_value = value.try(:strip).to_s.mb_chars.titleize
    super(new_value)
  end

  private

  def clear_phone_numbers
    self.phone_numbers = phone_numbers.split(',').map do |phone_number|
      phone_number.strip.gsub(/\A[^+\d]+\z/, '')
    end.join(',')
  end

  def phone_numbers_valid?
    return if phone_numbers.blank?

    phone_numbers.split(',').each do |phone_number|
      next if phone_number.strip =~ PHONE_NUMBERS_REGEX

      errors.add(:phone_numbers, :invalid)
    end
  end
end
