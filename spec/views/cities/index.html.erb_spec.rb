require 'rails_helper'

RSpec.describe 'cities/index', type: :view do
  let(:city1) { create(:city, name: 'Нефтеюганск') }
  let(:city2) { create(:city, name: 'Сургут') }

  before(:each) do
    @cities = assign(:cities, [city1, city2])
  end

  it 'renders a list of cities' do
    render

    assert_select 'h1', text: I18n.t('views.city.index.title'), count: 1

    expect(response.body).to have_link(I18n.t('views.city.index.new'), href: new_city_path)

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: City.human_attribute_name(:id), count: 1
        assert_select 'th', text: City.human_attribute_name(:name), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 2
        assert_select 'tr td', text: 'Нефтеюганск', count: 1
        assert_select 'tr td', text: 'Сургут', count: 1
      end
    end

    @cities.each do |city|
      expect(response.body).to have_link(I18n.t('views.show'), href: city_path(city))
      expect(response.body).to have_link(I18n.t('views.edit'), href: edit_city_path(city))
      expect(response.body).to have_link(I18n.t('views.destroy'), href: city_path(city))
    end
  end
end
