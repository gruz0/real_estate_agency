require 'rails_helper'

RSpec.describe 'employees/index', type: :view do
  let(:employee1) do
    create(:employee,
           email: 'me@domain.tld', last_name: 'Иванов', first_name: 'Иван', middle_name: 'Иванович',
           phone_numbers: '+79001112233', role: :admin)
  end
  let(:employee2) do
    create(:employee,
           email: 'me2@domain.tld', last_name: 'Петров', first_name: 'Сергей', phone_numbers: '+79993334455')
  end
  let(:employees) { [employee1, employee2] }

  it 'renders a list of employees' do
    assign(:employees, Kaminari.paginate_array(employees).page(1))

    render

    assert_select 'h1', text: I18n.t('views.employee.index.title'), count: 1

    expect(response.body).to have_link(I18n.t('views.employee.index.new'), href: new_employee_path)

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: Employee.human_attribute_name(:id), count: 1
        assert_select 'th', text: Employee.human_attribute_name(:fullname), count: 1
        assert_select 'th', text: Employee.human_attribute_name(:phone_numbers), count: 1
        assert_select 'th', text: Employee.human_attribute_name(:email), count: 1
        assert_select 'th', text: Employee.human_attribute_name(:role), count: 1
        assert_select 'th', text: Employee.human_attribute_name(:created_at), count: 1
        assert_select 'th', text: Employee.human_attribute_name(:updated_at), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 2
        assert_select 'tr>td', text: 'Иванов Иван Иванович'.to_s, count: 1
        assert_select 'tr>td', text: '+79001112233'.to_s, count: 1
        assert_select 'tr>td', text: 'me@domain.tld'.to_s, count: 1
        assert_select 'tr>td', text: 'admin'.to_s, count: 1

        assert_select 'tr>td', text: 'Петров Сергей'.to_s, count: 1
        assert_select 'tr>td', text: '+79993334455'.to_s, count: 1
        assert_select 'tr>td', text: 'me2@domain.tld'.to_s, count: 1
        assert_select 'tr>td', text: 'user'.to_s, count: 1
      end
    end

    employees.each do |employee|
      expect(response.body).to have_link(I18n.t('views.show'), href: employee_path(employee))
      expect(response.body).to have_link(I18n.t('views.edit'), href: edit_employee_path(employee))
      expect(response.body).to have_link(I18n.t('views.destroy'), href: employee_path(employee))
    end
  end
end
