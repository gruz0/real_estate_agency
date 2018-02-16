class EstateMaterial < ApplicationRecord
  has_many :estate, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3 }

  def name=(value)
    super(value.try(:strip))
  end
end
