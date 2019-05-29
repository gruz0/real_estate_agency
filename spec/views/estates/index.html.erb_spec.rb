require 'rails_helper'

RSpec.describe 'estates/index', type: :view do
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
      created_by_employee: employee,
      responsible_employee: employee,
      address: address,
      apartment_number: 55,
      estate_type: estate_type,
      estate_project: estate_project,
      estate_material: estate_material,
      client_full_name: 'Иванов Сергей Николаевич',
      client_phone_numbers: '+79991112233',
      number_of_rooms: 8,
      floor: 4,
      number_of_floors: 10,
      total_square_meters: 122.1,
      kitchen_square_meters: 17.9,
      description: 'Описание объекта',
      price: 99_999
    }
  end

  it 'renders a list of estates' do
    allow(view).to receive(:current_employee).and_return(employee)
    assign(:estates, Kaminari.paginate_array(estates).page(1))

    render template: 'estates/index', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.estate.index.title'), count: 1
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
        assert_select 'th', text: Client.model_name.human, count: 1
        assert_select 'th', text: Estate.human_attribute_name(:responsible_employee), count: 1
        assert_select 'th', text: Estate.human_attribute_name(:updated_at), count: 1

        assert_select 'button#show_filter', count: 1
        assert_select 'button#reset_estates_filter', count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 1
        assert_select 'tr>td', text: 'Нефтеюганск, Ленина, 9а, 55'.to_s, count: 1
        assert_select 'tr>td', text: 'Уральский'.to_s, count: 1
        assert_select 'tr>td', text: '8'.to_s, count: 1
        assert_select 'tr>td', text: '4/10'.to_s, count: 1
        assert_select 'tr>td', text: '99 999 000'.to_s, count: 1
        assert_select 'tr>td', text: '+79991112233'.to_s, count: 1
        assert_select 'tr>td', text: 'Ли М.П.'.to_s, count: 1
      end
    end

    estates.each do |estate|
      expect(response.body).to have_link(I18n.t('views.show'), href: estate_path(estate))
      expect(response.body).to have_link(I18n.t('views.edit'), href: edit_estate_path(estate))
      expect(response.body).to have_link(I18n.t('views.destroy'), href: estate_path(estate))
    end

    expect(response.body).to have_link(I18n.t('views.action'), href: '#', count: estates.size)

    # Filter bar
    assert_select '#estates_filter' do
      assert_select 'input#filter_id[type=text]', count: 1
      assert_select 'select#filter_city', count: 1 do
        assert_select 'option', text: I18n.t('views.filter.select.all'), count: 1
        assert_select 'option', text: city.name, count: 1
      end
      assert_select 'select#filter_street', count: 1 do
        assert_select 'option', text: I18n.t('views.filter.select.all'), count: 1
      end
      assert_select 'input#filter_building_number[type=text]', count: 1
      assert_select 'select#filter_estate_project', count: 1 do
        assert_select 'option', text: I18n.t('views.filter.select.all'), count: 1
      end
      assert_select 'input#filter_number_of_rooms[type=text]', count: 1
      assert_select 'input#filter_floor_from[type=text]', count: 1
      assert_select 'input#filter_floor_to[type=text]', count: 1
      assert_select 'input#filter_price_from[type=text]', count: 1
      assert_select 'input#filter_price_to[type=text]', count: 1
      assert_select 'input#filter_total_square_meters_from[type=text]', count: 1
      assert_select 'input#filter_total_square_meters_to[type=text]', count: 1
      assert_select 'input#filter_client_phone_numbers[type=text]', count: 1
      assert_select 'select#filter_responsible_employee', count: 1 do
        assert_select 'option', text: I18n.t('views.filter.select.all'), count: 1
        assert_select 'option', text: I18n.t('views.filter.select.i_am'), count: 1
      end
      assert_select 'select#filter_status', count: 1 do
        assert_select 'option', text: I18n.t('views.filter.select.all'), count: 1
        assert_select 'option', text: I18n.t('views.filter.select.active'), count: 1
        assert_select 'option', text: I18n.t('views.filter.select.delayed'), count: 1
      end
      assert_select 'button#filterize_estates', text: I18n.t('helpers.submit.filter'), count: 1
    end
  end

  it 'renders notice if estates was not found' do
    estates = []

    allow(view).to receive(:current_employee).and_return(employee)
    assign(:estates, Kaminari.paginate_array(estates).page(1))

    render template: 'estates/index', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.estate.index.title'), count: 1
    assert_select 'h1', text: I18n.t('views.estate.index.title'), count: 1

    expect(response.body).to have_link(I18n.t('views.estate.index.new'), href: new_estate_path)

    assert_select 'table' do
      assert_select 'tbody' do
        assert_select 'tr', count: 1
        assert_select 'tr>th', text: I18n.t('views.estate.index.estates_was_not_found'), count: 1
      end
    end
  end

  it 'colorize delayed estate' do
    delayed_estate = create(:estate, status: :delayed, delayed_until: Date.current + 3.days)

    estates = [estate1, delayed_estate]
    allow(view).to receive(:current_employee).and_return(employee)
    assign(:estates, Kaminari.paginate_array(estates).page(1))

    render template: 'estates/index', layout: 'layouts/application'

    assert_select 'table tbody' do
      assert_select 'tr', count: 2
      assert_select 'tr.table-secondary', count: 1
    end
  end
end
