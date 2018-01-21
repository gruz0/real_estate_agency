FactoryBot.define do
  factory :estate_type do
    name { "#{FFaker::Lorem.word}-#{rand(100)}" }
  end
end
