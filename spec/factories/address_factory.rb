# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    building_number { FFaker::Address.building_number }

    street
  end
end
