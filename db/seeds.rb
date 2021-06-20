# frozen_string_literal: true

#
# Competitors
#
Competitor.create!(name: 'Конкурент', phone_numbers: '+70001112234')

#
# Clients
#
Client.create!(full_name: 'Клиент', phone_numbers: '+79991112234')

#
# Employees
#
Employee.create!(
  email: 'root@example.com',
  password: '123456',
  role: :service_admin,
  last_name: 'Иванов',
  first_name: 'Иван',
  middle_name: 'Иванович'
)
admin = Employee.create!(
  email: 'me@example.com',
  password: '123456',
  role: :admin,
  last_name: 'Иванов',
  first_name: 'Иван',
  middle_name: 'Иванович'
)

#
# EstateTypes
#
estate_type = EstateType.create!(name: 'Квартира')

#
# EstateProjects
#
estate_project = EstateProject.create!(name: 'Уральский')

#
# EstateMaterials
#
estate_material = EstateMaterial.create!(name: 'Бетон')

#
# Cities
#
city = City.create!(name: 'Нефтеюганск')

#
# Streets
#
street = city.street.create!(name: '1-й мкрн')

#
# Addresses
#
address = Address.create!(street: street, building_number: '2')

#
# Estates
#
Estate.create!(
  created_by_employee: admin,
  responsible_employee: admin,
  address: address,
  estate_type: estate_type,
  estate_project: estate_project,
  estate_material: estate_material,
  client_full_name: 'Иванов Сергей',
  client_phone_numbers: '+79991112233',
  floor: 1,
  number_of_floors: 5,
  number_of_rooms: 3,
  apartment_number: 999,
  price: 30_000,
  status: :active
)
