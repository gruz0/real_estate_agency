FactoryBot.define do
  factory :employee, aliases: %i[responsible_employee created_by_employee] do
    last_name { FFaker::NameRU.last_name }
    first_name { FFaker::NameRU.first_name }
  end
end
