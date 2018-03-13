require 'rails_helper'

RSpec.describe 'estates/edit', type: :view do
  let(:employee) { create(:employee) }
  let(:city) { create(:city) }
  let(:street) { create(:street, city: city) }
  let(:address) { create(:address, street: street, building_number: '1/1') }
  let(:estate_type) { create(:estate_type) }
  let(:estate_project) { create(:estate_project) }
  let(:estate_material) { create(:estate_material) }
  let(:estate) { create(:estate, valid_attributes) }

  let(:valid_attributes) do
    {
      responsible_employee: employee,
      address: address,
      estate_type: estate_type,
      estate_project: estate_project,
      estate_material: estate_material,
      client_full_name: 'Иванова Наталья Сергеевна',
      client_phone_numbers: '+79990009988',
      price: 99_999,
      apartment_number: 55,
      number_of_rooms: 3,
      floor: 4,
      number_of_floors: 9,
      kitchen_square_meters: 42.1,
      total_square_meters: 99.3,
      description: 'Описание объекта недвижимости'
    }
  end

  login_employee

  it 'renders the edit estate form' do
    assign(:estate, estate)

    render

    assert_select 'h1', text: I18n.t('views.estate.edit.title'), count: 1

    assert_select 'form[action=?][method=?]', estate_path(estate), 'post' do
      assert_select 'input[name=?][value=?]', 'estate[client_full_name]', valid_attributes[:client_full_name]
      assert_select 'input[name=?][value=?]', 'estate[client_phone_numbers]', valid_attributes[:client_phone_numbers]
      assert_select 'input[name=?][disabled=disabled]', 'estate[created_by_employee]'
      assert_select 'select[name=?]', 'estate[responsible_employee]'
      assert_select 'select[name=?]', 'estate[city]'
      assert_select 'select[name=?]', 'estate[street]'
      assert_select 'input[name=?][value=?]', 'estate[building_number]', address.building_number
      assert_select 'input[name=?][value=?]', 'estate[apartment_number]', valid_attributes[:apartment_number].to_s
      assert_select 'select[name=?]', 'estate[estate_type]'
      assert_select 'select[name=?]', 'estate[estate_project]'
      assert_select 'select[name=?]', 'estate[estate_material]'
      assert_select 'input[name=?][value=?]', 'estate[number_of_rooms]', valid_attributes[:number_of_rooms].to_s
      assert_select 'input[name=?][value=?]', 'estate[floor]', valid_attributes[:floor].to_s
      assert_select 'input[name=?][value=?]', 'estate[number_of_floors]', valid_attributes[:number_of_floors].to_s
      assert_select 'input[name=?][value=?]', 'estate[total_square_meters]', valid_attributes[:total_square_meters].to_s
      assert_select 'input[name=?][value=?]', 'estate[kitchen_square_meters]',
                    valid_attributes[:kitchen_square_meters].to_s
      assert_select 'input[name=?][value=?]', 'estate[price]', valid_attributes[:price].to_s
      assert_select 'textarea[name=?]', 'estate[description]', valid_attributes[:description]

      # Ensure dictionaries have valid values
      selected_option = 'select[name=?] option[selected=selected][value=?]'
      assert_select selected_option, 'estate[estate_type]', estate_type.id.to_s
      assert_select selected_option, 'estate[responsible_employee]', employee.id.to_s
      assert_select selected_option, 'estate[city]', city.id.to_s
      assert_select selected_option, 'estate[street]', street.id.to_s
      assert_select selected_option, 'estate[estate_project]', estate_project.id.to_s
      assert_select selected_option, 'estate[estate_material]', estate_material.id.to_s
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.update'))
    expect(response.body).to have_link(I18n.t('views.back'), href: estates_path)
  end
end
