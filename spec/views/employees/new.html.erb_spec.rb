# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'employees/new', type: :view do
  let(:employee) { build(:employee) }

  it 'renders new employee form' do
    assign(:employee, employee)

    render template: 'employees/new', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.employee.new.title'), count: 1
    assert_select 'h1', text: I18n.t('views.employee.new.title'), count: 1

    assert_select 'form[action=?][method=?]', employees_path, 'post' do
      assert_select 'input[name=?][type=email]', 'employee[email]'
      assert_select 'input[name=?][type=password]', 'employee[password]'
      assert_select 'input[name=?][type=password]', 'employee[password_confirmation]'
      assert_select 'input[name=?]', 'employee[last_name]'
      assert_select 'input[name=?]', 'employee[first_name]'
      assert_select 'input[name=?]', 'employee[middle_name]'
      assert_select 'input[name=?]', 'employee[phone_numbers]'
      assert_select 'select[name=?]', 'employee[role]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.create'))
    expect(response.body).to have_link(I18n.t('views.back'), href: employees_path)
  end
end
