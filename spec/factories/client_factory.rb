FactoryBot.define do
  factory :client do
    full_name { "#{FFaker::NameRU.last_name} #{FFaker::NameRU.first_name}" }
    phone_numbers { FFaker::PhoneNumber.phone_number }
  end
end
