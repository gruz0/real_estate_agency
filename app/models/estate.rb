class Estate < ApplicationRecord
  DEAL_TYPES = %i[sale rent].freeze

  scope :sales, -> { where(deal_type: :sale) }
  scope :rents, -> { where(deal_type: :rent) }

  belongs_to :client
  belongs_to :employee
  belongs_to :address
  belongs_to :estate_type
  belongs_to :estate_project
  belongs_to :estate_material

  enum deal_type: { sale: 1, rent: 2 }
  enum status: { archived: 0, active: 1 }

  validates :deal_type, presence: true
  validates :client, presence: true
  validates :employee, presence: true
  validates :address, presence: true
  validates :estate_type, presence: true
  validates :estate_project, presence: true
  validates :estate_material, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :number_of_rooms, allow_blank: true, numericality: { greater_than: 0 }
  validates :floor, allow_blank: true, numericality: { greater_than: 0 }
  validates :number_of_floors, allow_blank: true, numericality: { greater_than: 0 }
  validates :total_square_meters, allow_blank: true, numericality: { greater_than: 0 }
  validates :kitchen_square_meters, allow_blank: true, numericality: { greater_than: 0 }

  class << self
    def deal_types
      DEAL_TYPES
    end
  end

  def building_number
    address&.building_number
  end
end
