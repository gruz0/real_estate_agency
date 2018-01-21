FactoryBot.define do
  factory :estate_material do
    name { "#{FFaker::Lorem.word}-#{rand(100)}" }
  end
end
