# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id            :bigint(8)        not null, primary key
#  full_name     :string(255)      not null
#  phone_numbers :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_clients_on_full_name      (full_name)
#  index_clients_on_phone_numbers  (phone_numbers)
#

class Client < ApplicationRecord
  include PhoneNumbers

  audited

  scope :ordered_by_full_name, -> { reorder('full_name ASC') }

  validates :full_name, presence: true, length: { minimum: 1 }

  def full_name=(value)
    new_value = value.try(:strip).to_s.mb_chars.titleize
    super(new_value)
  end
end
