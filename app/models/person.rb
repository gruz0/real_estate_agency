class Person < ApplicationRecord
  TYPES = %w[Employee Client].freeze

  validates :type, presence: true, inclusion: { in: TYPES }
  validates :last_name, presence: true, length: { minimum: 1 }
  validates :first_name, presence: true, length: { minimum: 1 }
  validates :phone_numbers, presence: true, length: { minimum: 10 }
  validates :active, presence: true, acceptance: true

  class << self
    def types
      TYPES
    end
  end
end
