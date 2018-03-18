class Estate < ApplicationRecord
  audited

  PHONE_NUMBERS_REGEX = /\A[+\d]+\z/

  enum status: { archived: 0, active: 1 }

  belongs_to :responsible_employee, class_name: 'Employee', inverse_of: :estate,
                                    foreign_key: :responsible_employee_id, required: true, validate: true
  belongs_to :created_by_employee, class_name: 'Employee', inverse_of: :estate,
                                   foreign_key: :created_by_employee_id, required: true, validate: true
  belongs_to :updated_by_employee, class_name: 'Employee', inverse_of: :estate,
                                   foreign_key: :updated_by_employee_id, required: false, validate: true
  belongs_to :address, required: true, validate: true
  belongs_to :estate_type, required: true, validate: true
  belongs_to :estate_project, required: true, validate: true
  belongs_to :estate_material, required: true, validate: true

  validates :client_full_name, presence: true, length: { minimum: 1 }
  validates :client_phone_numbers, presence: true, length: { minimum: 6 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 100_000 }
  validates :number_of_rooms, allow_blank: true, numericality: { greater_than: 0, less_than: 10 }
  validates :floor, allow_blank: true, numericality: { greater_than: 0, less_than: 100 }
  validates :number_of_floors, allow_blank: true, numericality: { greater_than: 0, less_than: 100 }
  validates :total_square_meters, allow_blank: true, numericality: { greater_than: 0, less_than: 1000 }
  validates :kitchen_square_meters, allow_blank: true, numericality: { greater_than: 0, less_than: 1000 }
  validate :client_phone_numbers_valid?

  delegate :building_number, to: :address, allow_nil: true
  delegate :name, to: :estate_type, prefix: true
  delegate :name, to: :estate_project, prefix: true
  delegate :name, to: :estate_material, prefix: true

  before_save :clear_client_phone_numbers

  def client_full_name=(value)
    new_value = value.try(:strip).to_s.mb_chars.titleize
    super(new_value)
  end

  def description=(value)
    super(value.try(:strip))
  end

  private

  def clear_client_phone_numbers
    self.client_phone_numbers = client_phone_numbers.split(',').map do |phone_number|
      phone_number.strip.gsub(/\A[^+\d]+\z/, '')
    end.join(',')
  end

  def client_phone_numbers_valid?
    return if client_phone_numbers.blank?

    client_phone_numbers.split(',').each do |phone_number|
      next if phone_number.strip =~ PHONE_NUMBERS_REGEX

      errors.add(:client_phone_numbers, :invalid)
    end
  end
end
