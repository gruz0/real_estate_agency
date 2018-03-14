class AddServiceAdmin < ActiveRecord::Migration[5.1]
  def self.up
    Employee.create!(
      email: 'root@example.com',
      password: '123456',
      role: :service_admin,
      last_name: 'Системный',
      first_name: 'Администратор'
    )
  end
end
