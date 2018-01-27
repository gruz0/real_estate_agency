require 'rails_helper'

RSpec.describe 'estates/new', type: :view do
  let(:client) { create(:client) }
  let(:employee) { create(:employee) }
  let(:city) { create(:city) }
  let(:street) { create(:street, city: city) }
  let(:address) { create(:address, street: street) }
  let(:estate_type) { create(:estate_type) }
  let(:estate_project) { create(:estate_project) }
  let(:estate_material) { create(:estate_material) }
  let(:estate) { build(:estate, valid_attributes) }

  let(:valid_attributes) do
    {
      client: client,
      employee: employee,
      address: address,
      estate_type: estate_type,
      estate_project: estate_project,
      estate_material: estate_material,
      price: 99_999.99,
      deal_type: :sale
    }
  end

  it 'renders new estate form' do
    assign(:estate, estate)

    render

    assert_select 'h1', text: I18n.t('views.estate.new.title'), count: 1

    assert_select 'form[action=?][method=?]', estates_path, 'post' do
      assert_select 'select[name=?]', 'estate[deal_type]'
      assert_select 'select[name=?]', 'estate[client]'
      assert_select 'select[name=?]', 'estate[employee]'
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
      assert_select 'input[name=?]', 'estate[description]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.create'))
    expect(response.body).to have_link(I18n.t('views.back'), href: estates_path)
  end
end
