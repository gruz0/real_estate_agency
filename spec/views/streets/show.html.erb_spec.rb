require 'rails_helper'

RSpec.describe 'streets/show', type: :view do
  let(:city) { create(:city, name: 'Нефтеюганск') }
  let(:street) { create(:street, city: city, name: 'ул. Ленина') }

  it 'renders attributes in <p>' do
    assign(:city, city)
    assign(:street, street)

    render

    expect(rendered).to match(I18n.t('views.street.show.title', id: street.id, city: city.name))

    expect(rendered).to match(/Нефтеюганск/)
    expect(rendered).to match(/ул. Ленина/)
    expect(rendered).to match(/#{street.created_at}/)
    expect(rendered).to match(/#{street.updated_at}/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_city_street_path(city, street))
    expect(response.body).to have_link(I18n.t('views.back'), href: city_streets_path(city))
  end
end
