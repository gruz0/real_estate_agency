# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_cities_on_name  (name) UNIQUE
#

class City < ApplicationRecord
  audited

  scope :with_streets, -> { reorder('name ASC').joins(:street).distinct }

  has_many :street, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3 }

  def name=(value)
    new_value = value.try(:strip).to_s.mb_chars.titleize
    super(new_value)
  end
end
