require 'rails_helper'

RSpec.describe 'employees/show', type: :view do
  let(:employee) do
    create(:employee, last_name: 'Иванов', first_name: 'Олег', middle_name: 'Сергеевич', phone_numbers: '+79991112233')
  end

  it 'renders attributes in <p>' do
    assign(:employee, employee)

    render

    expect(rendered).to match(I18n.t('views.employee.show.title', id: employee.id))

    expect(rendered).to match(/Иванов/)
    expect(rendered).to match(/Олег/)
    expect(rendered).to match(/Сергеевич/)
    expect(rendered).to match(/\+79991112233/)
    expect(rendered).to match(/#{employee.created_at}/)
    expect(rendered).to match(/#{employee.updated_at}/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_employee_path(employee))
    expect(response.body).to have_link(I18n.t('views.back'), href: employees_path)
  end
end
