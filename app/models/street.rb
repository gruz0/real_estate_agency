class Street < ApplicationRecord
  belongs_to :city
  has_many :address, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3 }

  delegate :name, to: :city, prefix: true

  def name=(value)
    super(value.try(:strip))
  end
end
