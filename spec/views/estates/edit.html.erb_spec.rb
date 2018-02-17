require 'rails_helper'

RSpec.describe 'estates/edit', type: :view do
  let(:client) { create(:client) }
  let(:employee) { create(:employee) }
  let(:city) { create(:city) }
  let(:street) { create(:street, city: city) }
  let(:address) { create(:address, street: street) }
  let(:estate_type) { create(:estate_type) }
  let(:estate_project) { create(:estate_project) }
  let(:estate_material) { create(:estate_material) }
  let(:estate) { create(:estate, valid_attributes) }

  let(:valid_attributes) do
    {
      client: client,
      responsible_employee: employee,
      address: address,
      estate_type: estate_type,
      estate_project: estate_project,
      estate_material: estate_material,
      price: 99_999
    }
  end

  login_employee

  it 'renders the edit estate form' do
    assign(:estate, estate)

    render

    assert_select 'h1', text: I18n.t('views.estate.edit.title'), count: 1

    assert_select 'form[action=?][method=?]', estate_path(estate), 'post' do
      assert_select 'select[name=?]', 'estate[client]'
      assert_select 'input[name=?][disabled=disabled]', 'estate[created_by_employee]'
      assert_select 'select[name=?]', 'estate[responsible_employee]'
      assert_select 'select[name=?]', 'estate[city]'
      assert_select 'select[name=?]', 'estate[street]'
      assert_select 'input[name=?]', 'estate[building_number]'
      assert_select 'input[name=?]', 'estate[apartment_number]'
      assert_select 'select[name=?]', 'estate[estate_type]'
      assert_select 'select[name=?]', 'estate[estate_project]'
      assert_select 'select[name=?]', 'estate[estate_material]'
      assert_select 'input[name=?]', 'estate[number_of_rooms]'
      assert_select 'input[name=?]', 'estate[floor]'
      assert_select 'input[name=?]', 'estate[number_of_floors]'
      assert_select 'input[name=?]', 'estate[total_square_meters]'
      assert_select 'input[name=?]', 'estate[kitchen_square_meters]'
      assert_select 'input[name=?]', 'estate[price]'
      assert_select 'textarea[name=?]', 'estate[description]'

      # Ensure dictionaries have valid values
      selected_option = 'select[name=?] option[selected=selected][value=?]'
      assert_select selected_option, 'estate[estate_type]', estate_type.id.to_s
      assert_select selected_option, 'estate[client]', client.id.to_s
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
