class EstateType < ApplicationRecord
  has_many :estate, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3 }

  def name=(value)
    new_value = value.try(:strip).to_s.mb_chars.capitalize
    super(new_value)
  end
end
