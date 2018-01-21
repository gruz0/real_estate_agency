FactoryBot.define do
  factory :estate_material do
    name { FFaker::LoremRU.unique.word * 3 }
  end
end
