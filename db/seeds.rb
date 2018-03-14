DatabaseCleaner.clean_with(:truncation)

#
# Competitors
#
Array.new(30).each do
  FactoryBot.create(:competitor, name: FFaker::NameRU.last_name, phone_numbers: "+7000111223#{rand(100)}")
end

#
# Clients
#
Array.new(30).each { FactoryBot.create(:client, phone_numbers: "+7999111223#{rand(100)}") }

#
# Employees
#
Array.new(30).each { FactoryBot.create(:employee, phone_numbers: "+7999999887#{rand(100)}") }
employee = FactoryBot.create(:employee, email: 'me@example.com', password: '123456', role: :admin)

#
# EstateTypes
#
estate_types = Array.new(30).map { FactoryBot.create(:estate_type) }

#
# EstateProjects
#
estate_projects = Array.new(30).map { FactoryBot.create(:estate_project) }

#
# EstateMaterials
#
estate_materials = Array.new(30).map { FactoryBot.create(:estate_material) }

#
# Cities
#
cities = Array.new(30).map { FactoryBot.create(:city) }

#
# Streets
#
streets = Array.new(30).map { FactoryBot.create(:street, city: cities.sample) }

#
# Addresses
#
addresses = Array.new(30).map do
  FactoryBot.create(:address, street: streets.sample, building_number: rand(1..100).to_s)
end

#
# Estates
#
500.times do |idx|
  Estate.create!(
    created_by_employee: employee,
    responsible_employee: employee,
    address: addresses.sample,
    estate_type: estate_types.sample,
    estate_project: estate_projects.sample,
    estate_material: estate_materials.sample,
    client_full_name: FFaker::NameRU.last_name,
    client_phone_numbers: "+7999111223#{idx}",
    floor: rand(1..5),
    number_of_floors: rand(5..9),
    number_of_rooms: [nil, rand(1..4)].sample,
    apartment_number: rand(100).to_s,
    price: rand(30_000.00..99_000.99),
    status: :active
  )
end
