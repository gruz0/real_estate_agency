FactoryBot.define do
  factory :address do
    building_number { FFaker::AddressRU.building_number }

    street
  end
end
