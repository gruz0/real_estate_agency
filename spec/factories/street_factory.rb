FactoryBot.define do
  factory :street do
    name { FFaker::AddressRU.unique.street_name }

    city
  end
end
