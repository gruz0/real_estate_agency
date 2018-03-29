require 'rails_helper'

RSpec.describe 'employees/show', type: :view do
  let(:employee) do
    create(:employee,
           email: 'me@domain.tld', last_name: 'Иванов', first_name: 'Олег', middle_name: 'Сергеевич',
           phone_numbers: '+79991112233', role: :admin)
  end

  it 'renders attributes in <p>' do
    assign(:employee, employee)

    Audited.audit_class.as_user(employee) do
      city = create(:city, name: 'Нефтеюганск')
      street = create(:street, city: city, name: 'ул. Ленина')
      create(:address, street: street, building_number: '7а')
    end

    render template: 'employees/show', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.employee.show.title', id: employee.id), count: 1
    expect(rendered).to match(I18n.t('views.employee.show.title', id: employee.id))

    expect(rendered).to match(/Иванов/)
    expect(rendered).to match(/Олег/)
    expect(rendered).to match(/Сергеевич/)
    expect(rendered).to match(/\+79991112233/)
    expect(rendered).to match(/me@domain.tld/)
    expect(rendered).to match(/admin/)
    expect(rendered).to match(/#{I18n.l(employee.created_at, format: :short)}/)
    expect(rendered).to match(/#{I18n.l(employee.updated_at, format: :short)}/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_employee_path(employee))
    expect(response.body).to have_link(I18n.t('views.back'), href: employees_path)

    expect(rendered).to match(I18n.t('views.employee.show.recent_actions'))

    assert_select 'table.audits' do
      assert_select 'thead' do
        assert_select 'th', text: I18n.t('views.audit.index.auditable_type'), count: 1
        assert_select 'th', text: I18n.t('views.audit.index.auditable_id'), count: 1
        assert_select 'th', text: I18n.t('views.audit.index.action'), count: 1
        assert_select 'th', text: I18n.t('views.audit.index.audited_changes'), count: 1
        assert_select 'th', text: I18n.t('views.audit.index.created_at'), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 3

        assert_select 'tr>th', text: 'City', count: 1
        assert_select 'tr>td', /Нефтеюганск/, count: 1

        assert_select 'tr>th', text: 'Street', count: 1
        assert_select 'tr>td', /ул. Ленина/, count: 1

        assert_select 'tr>th', text: 'Address', count: 1
        assert_select 'tr>td', /7а/, count: 1

        assert_select 'tr>td', text: 'create', count: 3
      end
    end
  end
end
