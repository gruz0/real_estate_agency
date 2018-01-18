class EstateType < ApplicationRecord
  has_many :estate, dependent: :destroy
end
