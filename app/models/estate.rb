class Estate < ApplicationRecord
  enum status: { archived: 0, active: 1 }

  belongs_to :client, required: true, validate: true
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

  validates :price, presence: true, numericality: { greater_than: 0, less_than: 100_000 }
  validates :number_of_rooms, allow_blank: true, numericality: { greater_than: 0, less_than: 10 }
  validates :floor, allow_blank: true, numericality: { greater_than: 0, less_than: 100 }
  validates :number_of_floors, allow_blank: true, numericality: { greater_than: 0, less_than: 100 }
  validates :total_square_meters, allow_blank: true, numericality: { greater_than: 0, less_than: 1000 }
  validates :kitchen_square_meters, allow_blank: true, numericality: { greater_than: 0, less_than: 1000 }

  delegate :building_number, to: :address, allow_nil: true
  delegate :name, to: :estate_type, prefix: true
  delegate :name, to: :estate_project, prefix: true
  delegate :name, to: :estate_material, prefix: true
  delegate :phone_numbers, :full_name, to: :client, prefix: true

  def description=(value)
    super(value.try(:strip))
  end
end
