require 'rails_helper'

RSpec.describe 'streets/index', type: :view do
  let(:city) { create(:city, name: 'Нефтеюганск') }

  before(:each) do
    assign(:city, city)

    Street.create!(city: city, name: 'ул. Ленина')
    Street.create!(city: city, name: 'ул. Усть-Балыкская')
    Street.create!(city: create(:city, name: 'Сургут'), name: 'ул. Нефтеюганская')
  end

  it 'renders a list of streets' do
    render
    assert_select 'h1', text: "Streets in #{city.name}", count: 1
    assert_select 'table tbody' do
      assert_select 'tr', count: 2
      assert_select 'tr>td', text: 'ул. Ленина'.to_s, count: 1
      assert_select 'tr>td', text: 'ул. Усть-Балыкская'.to_s, count: 1
    end
  end
end
