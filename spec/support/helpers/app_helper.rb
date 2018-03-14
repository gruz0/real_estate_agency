module AppHelper
  extend RSpec::SharedContext

  let(:response_hash) { JSON.parse(last_response.body, symbolize_names: true) }
  let(:json_headers) do
    {
      'CONTENT_TYPE' => 'application/json'
    }
  end

  let(:authenticated_employee) do
    Employee.create!(
      email: 'me@domain.tld',
      password: '123456',
      last_name: 'Директор',
      first_name: 'Компании',
      phone_numbers: '+79998887766'
    )
  end

  let(:authenticated_admin) do
    Employee.create!(
      email: 'admin@domain.tld',
      password: '123456',
      last_name: 'Директор',
      first_name: 'Компании',
      phone_numbers: '+79998887766',
      role: :admin
    )
  end

  let(:authenticated_service_admin) do
    Employee.create!(
      email: 'root@domain.tld',
      password: '123456',
      last_name: 'Системный',
      first_name: 'Администратор',
      phone_numbers: '+79999999999',
      role: :service_admin
    )
  end

  def prettify_json(json)
    JSON.pretty_generate(json)
  end
end
