require 'rails_helper'

RSpec.describe 'cities/show', type: :view do
  before(:each) do
    @city = assign(:city, City.create!(name: 'Нефтеюганск'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Нефтеюганск/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_city_path(@city))
    expect(response.body).to have_link(I18n.t('views.back'), href: cities_path)
  end
end
