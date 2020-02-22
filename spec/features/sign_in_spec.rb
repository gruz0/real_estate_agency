require 'rails_helper'

RSpec.feature 'Signing in' do
  let(:employee) { create(:employee) }

  scenario 'Signing in with correct credentials' do
    visit root_path

    fill_in 'employee[email]', with: employee.email
    fill_in 'employee[password]', with: employee.password
    click_button I18n.t('views.auth.new.log_in')

    expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
  end

  scenario 'Signing in with incorrect credentials' do
    visit root_path

    fill_in 'employee[email]', with: 'me@example.com'
    fill_in 'employee[password]', with: 'password'
    click_button I18n.t('views.auth.new.log_in')

    expect(page).to have_content(I18n.t('devise.failure.invalid', authentication_keys: 'Электронная почта'))
  end

  scenario 'When employee is locked' do
    employee.lock_access!

    visit root_path

    fill_in 'employee[email]', with: employee.email
    fill_in 'employee[password]', with: employee.password
    click_button I18n.t('views.auth.new.log_in')

    expect(page).to have_content(I18n.t('devise.failure.locked'))
  end
end
