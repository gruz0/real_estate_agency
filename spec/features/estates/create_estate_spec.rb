require 'rails_helper'

RSpec.feature 'Create Estate' do
  scenario 'Create estates' do
    employee = create(:employee)
    city     = create(:city, name: 'Нефтеюганск')
    street   = create(:street, city: city, name: 'ул. Ленина')
    create(:address, street: street, building_number: '3а')
    create(:estate_type, name: 'Квартира')
    create(:estate_project, name: 'Уральский')
    create(:estate_material, name: 'Кирпичный')

    visit root_path

    fill_in 'employee[email]', with: employee.email
    fill_in 'employee[password]', with: employee.password
    click_button I18n.t('views.auth.new.log_in')

    expect(page).to have_content(I18n.t('devise.sessions.signed_in'))

    visit new_estate_path

    select 'Нефтеюганск', from: 'estate[city]'
    select 'ул. Ленина', from: 'estate[street]'
    select 'Квартира', from: 'estate[estate_type]'
    select 'Уральский', from: 'estate[estate_project]'
    select 'Кирпичный', from: 'estate[estate_material]'

    fill_in 'estate[building_number]', with: '3а'
    fill_in 'estate[apartment_number]', with: '55'
    fill_in 'estate[client_full_name]', with: 'Сергеев Николай Петрович'
    fill_in 'estate[client_phone_numbers]', with: '+79992223344, 223344'
    fill_in 'estate[price]', with: '12345'
    fill_in 'estate[number_of_rooms]', with: '4'
    fill_in 'estate[floor]', with: '6'
    fill_in 'estate[number_of_floors]', with: '9'
    fill_in 'estate[total_square_meters]', with: '78'
    fill_in 'estate[kitchen_square_meters]', with: '38'
    fill_in 'estate[description]', with: 'Описание'

    click_button I18n.t('helpers.submit.create')

    expect(page).to have_content(I18n.t('views.estate.flash_messages.estate_was_successfully_created'))
  end
end
