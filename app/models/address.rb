class Address < ApplicationRecord
  belongs_to :street
  has_many :estate, dependent: :destroy
end
