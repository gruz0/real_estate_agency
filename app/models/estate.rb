class Estate < ApplicationRecord
  DEAL_TYPES = %i[sale rent].freeze

  scope :sales, -> { where(deal_type: :sale) }
  scope :rents, -> { where(deal_type: :rent) }

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

  enum deal_type: { sale: 1, rent: 2 }
  enum status: { archived: 0, active: 1 }

  validates :deal_type, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :number_of_rooms, allow_blank: true, numericality: { greater_than: 0, less_than: 10 }
  validates :floor, allow_blank: true, numericality: { greater_than: 0, less_than: 100 }
  validates :number_of_floors, allow_blank: true, numericality: { greater_than: 0, less_than: 100 }
  validates :total_square_meters, allow_blank: true, numericality: { greater_than: 0, less_than: 1000 }
  validates :kitchen_square_meters, allow_blank: true, numericality: { greater_than: 0, less_than: 1000 }

  class << self
    def deal_types
      DEAL_TYPES
    end
  end

  def building_number
    address&.building_number
  end
end
