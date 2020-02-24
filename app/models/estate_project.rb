# frozen_string_literal: true

# == Schema Information
#
# Table name: estate_projects
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_estate_projects_on_name  (name) UNIQUE
#

class EstateProject < ApplicationRecord
  audited

  has_many :estate, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3 }

  def name=(value)
    new_value = value.try(:strip).to_s.mb_chars.capitalize
    super(new_value)
  end
end
