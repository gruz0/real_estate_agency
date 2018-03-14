class Employee < ApplicationRecord
  scope :ordered_by_full_name, -> { reorder('last_name ASC, first_name ASC') }

  enum role: { user: 0, admin: 1, service_admin: 9 }

  has_many :estate, inverse_of: :responsible_employee, foreign_key: 'responsible_employee_id',
                    dependent: :restrict_with_error

  validates :last_name, presence: true, length: { minimum: 1 }
  validates :first_name, presence: true, length: { minimum: 1 }

  devise :database_authenticatable, :recoverable, :rememberable, :lockable, :trackable, :timeoutable, :validatable

  def last_name=(value)
    new_value = value.try(:strip).to_s.mb_chars.titleize
    super(new_value)
  end

  def first_name=(value)
    new_value = value.try(:strip).to_s.mb_chars.titleize
    super(new_value)
  end

  def middle_name=(value)
    new_value = value.try(:strip).to_s.mb_chars.titleize
    super(new_value)
  end
end
