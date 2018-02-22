class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :lockable, :trackable, :timeoutable, :validatable

  scope :ordered_by_full_name, -> { reorder('last_name ASC, first_name ASC') }

  has_many :estate, inverse_of: :responsible_employee, foreign_key: 'responsible_employee_id', dependent: :destroy

  enum role: { user: 0, admin: 1 }

  validates :last_name, presence: true, length: { minimum: 1 }
  validates :first_name, presence: true, length: { minimum: 1 }

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
