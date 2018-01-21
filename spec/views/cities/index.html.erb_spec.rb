require 'rails_helper'

RSpec.describe 'cities/index', type: :view do
  before(:each) do
    assign(:cities, [
             City.create!(name: 'Нефтеюганск'),
             City.create!(name: 'Пыть-Ях')
           ])
  end

  it 'renders a list of cities' do
    render
    assert_select 'tr>td', text: 'Нефтеюганск'.to_s, count: 1
    assert_select 'tr>td', text: 'Пыть-Ях'.to_s, count: 1
  end
end
