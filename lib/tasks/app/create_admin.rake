namespace :app do
  desc 'Creates default administrator'
  task create_admin: :environment do
    Employee.create!(
      email: 'me@example.com',
      password: '123456',
      role: :admin,
      first_name: 'Администратор',
      last_name: 'Системы'
    )
  end
end
