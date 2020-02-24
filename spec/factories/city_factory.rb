# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    name { FFaker::Address.city }
  end
end
