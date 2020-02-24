# frozen_string_literal: true

FactoryBot.define do
  factory :estate_project do
    name { generate(:random_name) }
  end
end
