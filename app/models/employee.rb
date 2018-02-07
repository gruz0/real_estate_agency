class Employee < ApplicationRecord
  has_many :estate, inverse_of: :responsible_employee, foreign_key: 'responsible_employee_id', dependent: :destroy

  validates :last_name, presence: true, length: { minimum: 1 }
  validates :first_name, presence: true, length: { minimum: 1 }
end
