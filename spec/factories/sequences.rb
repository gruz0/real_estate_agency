# frozen_string_literal: true

FactoryBot.define do
  sequence :random_name do |n|
    "#{FFaker::Lorem.word}-#{n}"
  end
end
