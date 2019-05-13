# == Schema Information
#
# Table name: competitors
#
#  id            :bigint(8)        not null, primary key
#  name          :string(255)
#  phone_numbers :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_competitors_on_name           (name)
#  index_competitors_on_phone_numbers  (phone_numbers)
#

class Competitor < ApplicationRecord
  include PhoneNumbers

  audited

  def name=(value)
    new_value = value.try(:strip).to_s.mb_chars.titleize
    super(new_value)
  end
end
