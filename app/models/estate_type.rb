class EstateType < ApplicationRecord
  has_many :estate, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3 }
end
