class City < ApplicationRecord
  scope :with_streets, -> { reorder('name ASC').joins(:street).distinct }

  has_many :street, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3 }
end
