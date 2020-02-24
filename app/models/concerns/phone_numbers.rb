# frozen_string_literal: true

module PhoneNumbers
  extend ActiveSupport::Concern

  included do
    validates :phone_numbers, presence: true, length: { minimum: 6 }
    validates_with PhoneNumbersValidator

    before_save :clear_phone_numbers

    private

    def clear_phone_numbers
      self.phone_numbers = phone_numbers.split(',').map do |phone_number|
        phone_number.strip.gsub(PHONE_NUMBERS_REGEX.to_s, '')
      end.join(',')
    end
  end
end
