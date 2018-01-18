class Estate < ApplicationRecord
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
end
