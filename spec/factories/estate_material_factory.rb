# frozen_string_literal: true

FactoryBot.define do
  factory :estate_material do
    name { generate(:random_name) }
  end
end
