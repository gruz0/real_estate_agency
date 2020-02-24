# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'employees/edit', type: :view do
  let(:employee) { create(:employee) }

  it 'renders the edit employee form' do
    assign(:employee, employee)

    render template: 'employees/edit', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.employee.edit.title'), count: 1
    assert_select 'h1', text: I18n.t('views.employee.edit.title'), count: 1

    assert_select 'form[action=?][method=?]', employee_path(employee), 'post' do
      assert_select 'input[name=?][type=email]', 'employee[email]'
      assert_select 'input[name=?][type=password]', 'employee[password]'
      assert_select 'input[name=?][type=password]', 'employee[password_confirmation]'
      assert_select 'input[name=?]', 'employee[last_name]'
      assert_select 'input[name=?]', 'employee[first_name]'
      assert_select 'input[name=?]', 'employee[middle_name]'
      assert_select 'input[name=?]', 'employee[phone_numbers]'
      assert_select 'select[name=?]', 'employee[role]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.update'))
    expect(response.body).to have_link(I18n.t('views.back'), href: employees_path)
  end
end
