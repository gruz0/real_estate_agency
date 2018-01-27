Person.delete_all
EstateType.delete_all
EstateProject.delete_all
EstateMaterial.delete_all
Address.delete_all
Street.delete_all
City.delete_all
Estate.delete_all

client   = Client.create!(last_name: 'Пупкин', first_name: 'Василий', phone_numbers: '+79151112233,+75159393132')
employee = Employee.create!(last_name: 'Иванова', first_name: 'Наталья', middle_name: 'Сергеевна',
                            phone_numbers: '+79001112233')

estate_types = ['Квартира', 'Дом', 'Комната', 'Нежилое помещение'].map do |type|
  EstateType.create!(name: type)
end

estate_projects = %w[Уральский Ленинградский Саратовский Московский].map do |project|
  EstateProject.create!(name: project)
end

estate_materials = %w[Панельный Деревянный Заливной Блочный Кирпичный].map do |material|
  EstateMaterial.create!(name: material)
end

city = City.create!(name: 'Нефтеюганск')
streets = ['1-й мкрн', '2-й мкрн', '3-й мкрн', 'ул. Ленина', 'ул. Усть-Балыкская'].map do |street|
  Street.create!(city: city, name: street)
end

addresses = ['1', '3а', '17/3'].map do |building_number|
  Address.create!(street: streets.sample, building_number: building_number)
end

3.times do |_|
  Estate.create(
    deal_type: :sale,
    employee: employee,
    client: client,
    address: addresses.sample,
    estate_type: estate_types.sample,
    estate_project: estate_projects.sample,
    estate_material: estate_materials.sample,
    floor: rand(1..5),
    number_of_floors: rand(5..9),
    number_of_rooms: [nil, rand(1..4)].sample,
    apartment_number: rand(100).to_s,
    price: rand(30_000.00..99_000.99),
    status: :active
  )
end

3.times do |_|
  Estate.create(
    deal_type: :rent,
    employee: employee,
    client: client,
    address: addresses.sample,
    estate_type: estate_types.sample,
    estate_project: estate_projects.sample,
    estate_material: estate_materials.sample,
    floor: [nil, rand(1..5)].sample,
    number_of_floors: [nil, rand(5..9)].sample,
    number_of_rooms: rand(1..4),
    apartment_number: rand(100).to_s,
    price: rand(30_000.00..99_000.99),
    status: :archived
  )
end
