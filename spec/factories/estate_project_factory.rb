FactoryBot.define do
  factory :estate_project do
    name { FFaker::LoremRU.unique.word * 3 }
  end
end
