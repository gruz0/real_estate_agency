FactoryBot.define do
  factory :estate_type do
    name { FFaker::LoremRU.unique.word * 3 }
  end
end
