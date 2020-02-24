# frozen_string_literal: true

class PhoneNumbersValidator < ActiveModel::Validator
  attr_reader :record

  def validate(record)
    @record = record

    phone_numbers_valid?
  end

  private

  def phone_numbers_valid?
    return if record.phone_numbers.blank?

    record.phone_numbers.split(',').each do |phone_number|
      next if PHONE_NUMBERS_REGEX.match?(phone_number.strip)

      record.errors.add(:phone_numbers, :invalid)
    end
  end
end
