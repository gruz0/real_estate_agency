require 'rails_helper'

RSpec.describe 'cities/show', type: :view do
  let(:city) { create(:city, name: 'Нефтеюганск') }

  it 'renders attributes in <p>' do
    assign(:city, city)

    render

    expect(rendered).to match(/Нефтеюганск/)
    expect(rendered).to match(/#{city.created_at}/)
    expect(rendered).to match(/#{city.updated_at}/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_city_path(city))
    expect(response.body).to have_link(I18n.t('views.back'), href: cities_path)
  end
end
