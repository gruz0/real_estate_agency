class Person < ApplicationRecord
  scope :employees, -> { where(type: 'Employee') }
  scope :clients, -> { where(type: 'Client') }

  class << self
    def types
      %w[Employee Client]
    end
  end
end
