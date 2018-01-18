class Street < ApplicationRecord
  belongs_to :city
  has_many :address, dependent: :destroy
end
