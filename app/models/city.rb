class City < ApplicationRecord
  scope :with_streets, -> { reorder('name ASC').joins(:street).distinct }

  has_many :street, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3 }

  def name=(value)
    new_value = value.try(:strip).to_s.mb_chars.titleize
    super(new_value)
  end
end
