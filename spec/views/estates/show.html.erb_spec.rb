require 'rails_helper'

RSpec.describe 'estates/show', type: :view do
  let(:client) do
    create(:client, last_name: 'Иванов', first_name: 'Сергей', middle_name: 'Николаевич', phone_numbers: '+79991112233')
  end
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
      number_of_rooms: 6,
      floor: 4,
      number_of_floors: 10,
      total_square_meters: 122.1,
      kitchen_square_meters: 17.8,
      description: 'Описание объекта',
      price: 99_999.99
    }
  end

  it 'renders attributes in <p>' do
    assign(:estate, estate)

    render

    expect(rendered).to match(I18n.t('views.estate.show.title', id: estate.id))

    expect(rendered).to match(/sale/)
    expect(rendered).to match(/Нефтеюганск, Ленина, 9а/)
    expect(rendered).to match(/99999\.99/)
    expect(rendered).to match(/Иванов Сергей Николаевич/)
    expect(rendered).to match(/\+79991112233/)
    expect(rendered).to match(/Ли Мария Петровна/)
    expect(rendered).to match(/Квартира/)
    expect(rendered).to match(/Уральский/)
    expect(rendered).to match(/Арбоблочный/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(%r{4/10})
    expect(rendered).to match(/122\.1/)
    expect(rendered).to match(/17\.8/)
    expect(rendered).to match(/Описание объекта/)
    expect(rendered).to match(/#{estate.created_at}/)
    expect(rendered).to match(/#{estate.updated_at}/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_estate_path(estate))
    expect(response.body).to have_link(I18n.t('views.back'), href: estates_path)
  end
end
