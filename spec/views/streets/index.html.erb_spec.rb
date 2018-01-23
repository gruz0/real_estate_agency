require 'rails_helper'

RSpec.describe 'streets/index', type: :view do
  let(:city) { create(:city, name: 'Нефтеюганск') }

  before(:each) do
    assign(:city, city)

    @streets = [
      Street.create!(city: city, name: 'ул. Ленина'),
      Street.create!(city: city, name: 'ул. Усть-Балыкская')
    ]

    Street.create!(city: create(:city, name: 'Сургут'), name: 'ул. Нефтеюганская')
  end

  it 'renders a list of streets' do
    render

    assert_select 'h1', text: I18n.t('views.street.index.title', city: city.name), count: 1

    expect(response.body).to have_link(I18n.t('views.street.index.new'), href: new_city_street_path(city))

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: Street.human_attribute_name(:id), count: 1
        assert_select 'th', text: Street.human_attribute_name(:name), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 2
        assert_select 'tr>td', text: 'ул. Ленина'.to_s, count: 1
        assert_select 'tr>td', text: 'ул. Усть-Балыкская'.to_s, count: 1
      end
    end

    @streets.each do |street|
      expect(response.body).to have_link(I18n.t('views.show'), href: city_street_path(city, street))
      expect(response.body).to have_link(I18n.t('views.edit'), href: edit_city_street_path(city, street))
      expect(response.body).to have_link(I18n.t('views.destroy'), href: city_street_path(city, street))
    end
  end
end
