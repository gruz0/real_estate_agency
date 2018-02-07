class Client < ApplicationRecord
  has_many :estate, dependent: :destroy

  validates :full_name, presence: true, length: { minimum: 1 }
  validates :phone_numbers, presence: true, length: { minimum: 10 }
end
