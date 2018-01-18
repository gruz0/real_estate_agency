class EstateMaterial < ApplicationRecord
  has_many :estate, dependent: :destroy
end
