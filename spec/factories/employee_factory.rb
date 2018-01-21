FactoryBot.define do
  factory :employee do
    type 'Employee'
    last_name { FFaker::NameRU.last_name }
    first_name { FFaker::NameRU.first_name }
    phone_numbers { FFaker::PhoneNumber.phone_number }
    active 1
  end
end
