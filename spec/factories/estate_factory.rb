FactoryBot.define do
  factory :estate do
    deal_type :sale
    price 99_999.99

    estate_type
    estate_project
    estate_material
    address
    client
    responsible_employee
    created_by_employee
  end
end
