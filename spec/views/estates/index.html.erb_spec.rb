require 'rails_helper'

RSpec.describe 'estates/index', type: :view do
  let(:client) do
    create(:client, last_name: 'Иванов', first_name: 'Сергей', middle_name: 'Николаевич', phone_numbers: '+79991112233')
  end
  let(:employee) do
    create(:employee, last_name: 'Ли', first_name: 'Мария', middle_name: 'Петровна', phone_numbers: '+79004445566')
  end
  let(:city) { create(:city, name: 'Нефтеюганск') }
  let(:street) { create(:street, city: city, name: 'Ленина') }
  let(:address) { create(:address, street: street, building_number: '9а') }
  let(:estate_type) { create(:estate_type) }
  let(:estate_project) { create(:estate_project, name: 'Уральский') }
  let(:estate_material) { create(:estate_material) }
  let(:estate1) { create(:estate, valid_attributes) }
  let(:estates) { [estate1] }

  let(:valid_attributes) do
    {
      deal_type: :sale,
      client: client,
      employee: employee,
      address: address,
      apartment_number: 55,
      estate_type: estate_type,
      estate_project: estate_project,
      estate_material: estate_material,
      number_of_rooms: 8,
      floor: 4,
      number_of_floors: 10,
      total_square_meters: 122.1,
      kitchen_square_meters: 17.9,
      description: 'Описание объекта',
      price: 99_999.99
    }
  end

  it 'renders a list of estates' do
    assign(:estates, estates)
    flash[:notice] = 'Notice'

    render

    assert_select '.alert span', text: 'Notice', count: 1
    assert_select 'h1', text: I18n.t('views.estate.index.title'), count: 1

    expect(response.body).to have_link(I18n.t('views.estate.index.new'), href: new_estate_path)

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: Estate.human_attribute_name(:id), count: 1
        assert_select 'th', text: Estate.human_attribute_name(:address), count: 1
        assert_select 'th', text: Estate.human_attribute_name(:estate_project), count: 1
        assert_select 'th', text: Estate.human_attribute_name(:number_of_rooms), count: 1
        assert_select 'th', text: Estate.human_attribute_name(:floor), count: 1
        assert_select 'th', text: Estate.human_attribute_name(:price), count: 1
        assert_select 'th', text: Person.human_attribute_name(:phone_numbers), count: 1
        assert_select 'th', text: Estate.human_attribute_name(:employee), count: 1
        assert_select 'th', text: Estate.human_attribute_name(:created_at), count: 1
        assert_select 'th', text: Estate.human_attribute_name(:updated_at), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 1
        assert_select 'tr>td', text: 'Нефтеюганск, Ленина, 9а'.to_s, count: 1
        assert_select 'tr>td', text: 'Уральский'.to_s, count: 1
        assert_select 'tr>td', text: '8'.to_s, count: 1
        assert_select 'tr>td', text: '4/10'.to_s, count: 1
        assert_select 'tr>td', text: '99999.99'.to_s, count: 1
        assert_select 'tr>td', text: '+79991112233'.to_s, count: 1
        assert_select 'tr>td', text: 'Ли М.П.'.to_s, count: 1
        assert_select 'tr td', text: estate1.created_at.to_s, count: 2
      end
    end

    estates.each do |estate|
      expect(response.body).to have_link(I18n.t('views.show'), href: estate_path(estate))
      expect(response.body).to have_link(I18n.t('views.edit'), href: edit_estate_path(estate))
      expect(response.body).to have_link(I18n.t('views.destroy'), href: estate_path(estate))
    end

    expect(response.body).to have_link(I18n.t('views.action'), href: '#', count: estates.size)
  end
end
