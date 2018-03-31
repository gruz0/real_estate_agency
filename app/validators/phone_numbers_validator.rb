class PhoneNumbersValidator < ActiveModel::Validator
  PHONE_NUMBERS_REGEX = /\A[+\d]+\z/

  attr_reader :record

  def validate(record)
    @record = record

    phone_numbers_valid?
  end

  private

  def phone_numbers_valid?
    return if record.phone_numbers.blank?

    record.phone_numbers.split(',').each do |phone_number|
      next if phone_number.strip =~ PHONE_NUMBERS_REGEX

      record.errors.add(:phone_numbers, :invalid)
    end
  end
end
