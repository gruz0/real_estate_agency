FactoryBot.define do
  factory :estate_project do
    name { "#{FFaker::Lorem.word}-#{rand(100)}" }
  end
end
