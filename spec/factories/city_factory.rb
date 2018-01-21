FactoryBot.define do
  factory :city do
    name { FFaker::AddressRU.unique.city }
  end
end
