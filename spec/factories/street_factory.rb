# frozen_string_literal: true

FactoryBot.define do
  factory :street do
    name { FFaker::Address.street_name }

    city
  end
end
