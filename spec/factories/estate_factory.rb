FactoryBot.define do
  factory :estate do
    client_full_name { 'Иванова Наталья Сергеевна' }
    client_phone_numbers { '+79991112233, 555666' }
    price { 99_999 }

    estate_type
    estate_project
    estate_material
    address
    responsible_employee
    created_by_employee
  end
end
