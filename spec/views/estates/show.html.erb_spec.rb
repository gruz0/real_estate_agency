require 'rails_helper'

RSpec.describe 'estates/show', type: :view do
  let(:employee) do
    create(:employee, last_name: 'Ли', first_name: 'Мария', middle_name: 'Петровна', phone_numbers: '+79004445577')
  end
  let(:city) { create(:city, name: 'Нефтеюганск') }
  let(:street) { create(:street, city: city, name: 'Ленина') }
  let(:address) { create(:address, street: street, building_number: '9а') }
  let(:estate_type) { create(:estate_type, name: 'Квартира') }
  let(:estate_project) { create(:estate_project, name: 'Уральский') }
  let(:estate_material) { create(:estate_material, name: 'Арбоблочный') }
  let(:estate) { create(:estate, valid_attributes) }

  let(:link_in_description) { 'https://github.com/gruz0/real_estate_agency/blob/master/.env.sample' }
  let(:valid_attributes) do
    {
      created_by_employee: create(:employee, last_name: 'Сергеев', first_name: 'Алексей'),
      updated_by_employee: create(:employee, last_name: 'Петров', first_name: 'Олег'),
      responsible_employee: employee,
      address: address,
      apartment_number: 55,
      estate_type: estate_type,
      estate_project: estate_project,
      estate_material: estate_material,
      client_full_name: 'Иванов Сергей Николаевич',
      client_phone_numbers: '+79991112233, 83331112244',
      number_of_rooms: 6,
      floor: 4,
      number_of_floors: 10,
      total_square_meters: 122.1,
      kitchen_square_meters: 17.8,
      description: "Описание объекта - #{link_in_description}",
      price: 99_999
    }
  end

  it 'renders attributes in <p>' do
    assign(:estate, estate)

    render template: 'estates/show', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.estate.show.title', id: estate.id), count: 1
    expect(response.body).to match(I18n.t('views.estate.show.title', id: estate.id))

    expect(response.body).to match(/Нефтеюганск, Ленина, 9а, 55/)
    expect(response.body).to match(/99 999 000/)
    expect(response.body).to match(/Иванов Сергей Николаевич/)
    expect(response.body).to match(/Ли Мария Петровна/)
    expect(response.body).to match(/Квартира/)
    expect(response.body).to match(/Уральский/)
    expect(response.body).to match(/Арбоблочный/)
    expect(response.body).to match(/6/)
    expect(response.body).to match(%r{4/10})
    expect(response.body).to match(/122\.1/)
    expect(response.body).to match(/17\.8/)
    expect(response.body).to match(/Описание объекта/)
    expect(response.body).to have_link(link_in_description, href: link_in_description)
    expect(response.body).to match(/Сергеев Алексей/)
    expect(response.body).to match(/#{I18n.l(estate.created_at, format: :short)}/)
    expect(response.body).to match(/Петров Олег/)
    expect(response.body).to match(/#{I18n.l(estate.updated_at, format: :short)}/)

    estate.client_phone_numbers.split(',').each do |phone_number|
      expect(response.body).to have_link(phone_number.strip, href: "tel://#{phone_number.strip}")
    end

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_estate_path(estate))
    expect(response.body).to have_link(I18n.t('views.back'), href: estates_path)
  end
end
