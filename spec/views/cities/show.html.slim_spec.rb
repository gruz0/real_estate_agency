require 'rails_helper'

RSpec.describe 'cities/show', type: :view do
  let(:city) { create(:city, name: 'Нефтеюганск') }

  it 'renders attributes in <p>' do
    assign(:city, city)

    render

    expect(rendered).to match(I18n.t('views.city.show.title', id: city.id))

    expect(rendered).to match(/Нефтеюганск/)
    expect(rendered).to match(/#{I18n.l(city.created_at, format: :short)}/)
    expect(rendered).to match(/#{I18n.l(city.updated_at, format: :short)}/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_city_path(city))
    expect(response.body).to have_link(I18n.t('views.back'), href: cities_path)
  end
end
