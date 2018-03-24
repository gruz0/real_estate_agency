class Employee < ApplicationRecord
  audited only: %i[email role last_name first_name middle_name last_sign_in_at last_sign_in_ip]

  scope :ordered_by_full_name, -> { reorder('last_name ASC, first_name ASC') }

  enum role: { user: 0, admin: 1, service_admin: 9 }

  has_many :estate, inverse_of: :responsible_employee, foreign_key: 'responsible_employee_id',
                    dependent: :restrict_with_error

  # Uses by :prevent_to_destroy_last_employee before_destroy filter
  attr_reader :last_employee

  validates :last_name, presence: true, length: { minimum: 1 }
  validates :first_name, presence: true, length: { minimum: 1 }

  before_destroy :prevent_to_destroy_last_employee

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

  private

  def prevent_to_destroy_last_employee
    return if Employee.count > 1

    errors.add(:last_employee, :unable_to_be_destroyed)
    throw :abort
  end
end
