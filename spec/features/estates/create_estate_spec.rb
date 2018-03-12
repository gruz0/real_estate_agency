require 'rails_helper'

RSpec.feature 'Create Estate' do
  let!(:employee) { create(:employee) }
  let!(:client) { create(:client) }
  let!(:responsible_employee) { create(:employee) }
  let!(:city) { create(:city, name: 'Нефтеюганск') }
  let!(:street) { create(:street, city: city, name: 'ул. Ленина') }
  let!(:address) { create(:address, street: street, building_number: '3а') }
  let!(:estate_type) { create(:estate_type, name: 'Квартира') }
  let!(:estate_project) { create(:estate_project, name: 'Уральский') }
  let!(:estate_material) { create(:estate_material, name: 'Кирпичный') }

  scenario 'Create estates' do
    visit root_path

    fill_in 'employee[email]', with: employee.email
    fill_in 'employee[password]', with: employee.password
    click_button I18n.t('views.auth.new.log_in')

    expect(page).to have_content(I18n.t('devise.sessions.signed_in'))

    visit new_estate_path

    select 'Нефтеюганск', from: 'Город'
    select 'ул. Ленина', from: 'Улица'
    select 'Квартира', from: 'Тип'
    select 'Уральский', from: 'Проект'
    select 'Кирпичный', from: 'Материал'

    fill_in 'estate[building_number]', with: '3а'
    fill_in 'estate[apartment_number]', with: '55'
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
