# frozen_string_literal: true

# == Schema Information
#
# Table name: estates
#
#  id                      :bigint(8)        not null, primary key
#  estate_type_id          :bigint(8)        not null
#  estate_project_id       :bigint(8)        not null
#  estate_material_id      :bigint(8)        not null
#  address_id              :bigint(8)        not null
#  responsible_employee_id :bigint(8)        not null
#  created_by_employee_id  :bigint(8)        not null
#  updated_by_employee_id  :bigint(8)
#  number_of_rooms         :integer
#  floor                   :integer
#  number_of_floors        :integer
#  total_square_meters     :float(24)
#  kitchen_square_meters   :float(24)
#  description             :text(65535)
#  apartment_number        :string(255)
#  price                   :integer          not null
#  status                  :integer          default("active"), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  client_full_name        :string(255)      default(""), not null
#  client_phone_numbers    :string(255)      default(""), not null
#  delayed_until           :date
#
# Indexes
#
#  index_estates_on_address_id               (address_id)
#  index_estates_on_created_by_employee_id   (created_by_employee_id)
#  index_estates_on_estate_material_id       (estate_material_id)
#  index_estates_on_estate_project_id        (estate_project_id)
#  index_estates_on_estate_type_id           (estate_type_id)
#  index_estates_on_price                    (price)
#  index_estates_on_responsible_employee_id  (responsible_employee_id)
#  index_estates_on_status                   (status)
#  index_estates_on_updated_by_employee_id   (updated_by_employee_id)
#
# Foreign Keys
#
#  fk_rails_7bdb140bf1  (responsible_employee_id => employees.id)
#  fk_rails_80b4809276  (estate_material_id => estate_materials.id)
#  fk_rails_82a45a7167  (created_by_employee_id => employees.id)
#  fk_rails_bd9d953217  (updated_by_employee_id => employees.id)
#  fk_rails_bf98245067  (address_id => addresses.id)
#  fk_rails_c183bb2c54  (estate_project_id => estate_projects.id)
#  fk_rails_fd9fead491  (estate_type_id => estate_types.id)
#

class Estate < ApplicationRecord
  audited

  enum status: { archived: 0, active: 1, delayed: 2 }

  belongs_to :responsible_employee, class_name: 'Employee', inverse_of: :estate, validate: true
  belongs_to :created_by_employee, class_name: 'Employee', inverse_of: :estate, validate: true
  belongs_to :updated_by_employee, class_name: 'Employee', inverse_of: :estate, optional: true, validate: true
  belongs_to :address, validate: true
  belongs_to :estate_type, validate: true
  belongs_to :estate_project, validate: true
  belongs_to :estate_material, validate: true

  validates :client_full_name, presence: true, length: { minimum: 1 }
  validates :client_phone_numbers, presence: true, length: { minimum: 6 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 100_000 }
  validates :number_of_rooms, allow_blank: true, numericality: { greater_than: 0, less_than: 10 }
  validates :floor, allow_blank: true, numericality: { greater_than: 0, less_than: 100 }
  validates :number_of_floors, allow_blank: true, numericality: { greater_than: 0, less_than: 100 }
  validates :total_square_meters, allow_blank: true, numericality: { greater_than: 0, less_than: 1000 }
  validates :kitchen_square_meters, allow_blank: true, numericality: { greater_than: 0, less_than: 1000 }
  validate :client_phone_numbers_valid?
  validates_datetime :delayed_until, allow_nil: true, after: -> { Date.current }
  validate :saveable?

  delegate :building_number, to: :address, allow_nil: true
  delegate :name, to: :estate_type, prefix: true
  delegate :name, to: :estate_project, prefix: true
  delegate :name, to: :estate_material, prefix: true

  before_save :clear_client_phone_numbers

  def created_by?(employee)
    created_by_employee.eql?(employee)
  end

  def assigned_to?(employee)
    responsible_employee.eql?(employee)
  end

  def updateable_by?(employee)
    created_by?(employee) || assigned_to?(employee)
  end

  def client_full_name=(value)
    new_value = value.try(:strip).to_s.mb_chars.titleize
    super(new_value)
  end

  def description=(value)
    super(value.try(:strip))
  end

  # FIXME: It should be moved to EstateForm
  def delay(employee:, delayed_until:)
    self.updated_by_employee = employee
    self.delayed_until = delayed_until
    self.status = :delayed

    save
  end

  # FIXME: It should be moved to EstateForm
  def cancel_delay(employee:)
    self.updated_by_employee = employee
    self.delayed_until = nil
    self.status = :active

    save
  end

  private

  def clear_client_phone_numbers
    self.client_phone_numbers = client_phone_numbers.split(',').map do |phone_number|
      phone_number.strip.gsub(PHONE_NUMBERS_REGEX.to_s, '')
    end.join(',')
  end

  def client_phone_numbers_valid?
    return if client_phone_numbers.blank?

    client_phone_numbers.split(',').each do |phone_number|
      next if PHONE_NUMBERS_REGEX.match?(phone_number.strip)

      errors.add(:client_phone_numbers, :invalid)
    end
  end

  def saveable?
    if apartment_number.blank?
      return if client_phone_numbers.blank?

      clear_client_phone_numbers

      return unless similar_estates_exist?

      errors.add(:base, :client_phone_numbers_at_this_building_number_already_exist)
      return false
    end

    estate = Estate.find_by(address: address, apartment_number: apartment_number)
    return unless estate
    return if estate.id == id

    errors.add(:base, :estate_at_this_address_already_exists)
  end

  def similar_estates_exist?
    similar_estates = Estate.where(address: address, client_phone_numbers: client_phone_numbers)
    return if similar_estates.size.zero?
    return if similar_estates.any? { |estate| estate.id == id }

    true
  end
end
