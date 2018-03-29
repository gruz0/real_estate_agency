require 'rails_helper'

RSpec.describe 'cities/edit', type: :view do
  let(:city) { create(:city) }

  it 'renders the edit city form' do
    assign(:city, city)

    render template: 'cities/edit', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.city.edit.title'), count: 1
    assert_select 'h1', text: I18n.t('views.city.edit.title'), count: 1

    assert_select 'form[action=?][method=?]', city_path(city), 'post' do
      assert_select 'input[name=?]', 'city[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.update'))
    expect(response.body).to have_link(I18n.t('views.back'), href: cities_path)
  end
end
