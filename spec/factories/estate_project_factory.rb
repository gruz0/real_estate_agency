FactoryBot.define do
  factory :estate_project do
    name { FFaker::Lorem.word * 3 }
  end
end
