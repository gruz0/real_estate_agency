FactoryBot.define do
  factory :client do
    full_name { "#{FFaker::NameRU.last_name} #{FFaker::NameRU.first_name}" }
    phone_numbers { '+79998887766' }
  end
end
