# == Schema Information
#
# Table name: employees
#
#  id                     :bigint(8)        not null, primary key
#  last_name              :string(255)      not null
#  first_name             :string(255)      not null
#  middle_name            :string(255)
#  phone_numbers          :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  role                   :integer          default("user"), not null
#
# Indexes
#
#  index_employees_on_email                 (email) UNIQUE
#  index_employees_on_last_name             (last_name)
#  index_employees_on_reset_password_token  (reset_password_token) UNIQUE
#  index_employees_on_unlock_token          (unlock_token) UNIQUE
#

class Employee < ApplicationRecord
  audited only: %i[email role last_name first_name middle_name last_sign_in_at last_sign_in_ip locked_at]

  scope :ordered_by_full_name, -> { reorder('last_name ASC, first_name ASC') }

  enum role: { user: 0, admin: 1, service_admin: 9 }

  has_many :estate, inverse_of: :responsible_employee, foreign_key: 'responsible_employee_id',
                    dependent: :restrict_with_error

  # Uses by :prevent_to_destroy_last_employee before_destroy filter
  attr_reader :last_employee

  validates :last_name, presence: true, length: { minimum: 1 }
  validates :first_name, presence: true, length: { minimum: 1 }
  validates_with PhoneNumbersValidator

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
