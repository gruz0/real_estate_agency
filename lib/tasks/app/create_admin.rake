namespace :app do
  desc 'Creates administrators'
  task create_admin: :environment do
    Employee.create!(
      email: 'root@example.com',
      password: '123456',
      role: :service_admin,
      last_name: 'Системный',
      first_name: 'Администратор'
    )

    Employee.create!(
      email: 'me@example.com',
      password: '123456',
      role: :admin,
      first_name: 'Администратор',
      last_name: 'Системы'
    )
  end
end
