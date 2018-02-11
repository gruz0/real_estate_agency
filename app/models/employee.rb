class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :lockable, :trackable, :timeoutable

  has_many :estate, inverse_of: :responsible_employee, foreign_key: 'responsible_employee_id', dependent: :destroy

  validates :last_name, presence: true, length: { minimum: 1 }
  validates :first_name, presence: true, length: { minimum: 1 }
end
