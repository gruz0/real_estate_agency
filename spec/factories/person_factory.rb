FactoryBot.define do
  factory :person do
    type 'Client'
    last_name { FFaker::NameRU.last_name }
    first_name { FFaker::NameRU.first_name }
    phone_numbers { FFaker::PhoneNumber.phone_number }
    active 1
  end
end
