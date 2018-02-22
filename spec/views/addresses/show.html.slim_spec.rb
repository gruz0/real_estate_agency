require 'rails_helper'

RSpec.describe 'addresses/show', type: :view do
  let(:city) { create(:city, name: 'Нефтеюганск') }
  let(:street) { create(:street, city: city, name: 'ул. Ленина') }
  let(:address) { create(:address, street: street, building_number: '72а') }

  it 'renders attributes in <p>' do
    assign(:address, address)

    render

    expect(rendered).to match(I18n.t('views.address.show.title', id: address.id, city: city.name, street: street.name))

    expect(rendered).to match(/Нефтеюганск/)
    expect(rendered).to match(/ул. Ленина/)
    expect(rendered).to match(/72а/)
    expect(rendered).to match(/#{address.created_at}/)
    expect(rendered).to match(/#{address.updated_at}/)

    expect(response.body).to have_link(I18n.t('views.back'), href: addresses_path)
  end
end
