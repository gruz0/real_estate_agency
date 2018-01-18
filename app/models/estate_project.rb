class EstateProject < ApplicationRecord
  has_many :estate, dependent: :destroy
end
