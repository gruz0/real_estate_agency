require 'rails_helper'

RSpec.describe 'streets/index', type: :view do
  let(:city) { create(:city, name: 'Нефтеюганск') }

  before(:each) do
    assign(:streets, [
             Street.create!(city: city, name: 'ул. Ленина'),
             Street.create!(city: city, name: 'ул. Усть-Балыкская')
           ])
  end

  it 'renders a list of streets' do
    render
    assert_select 'tr>td', text: 'Нефтеюганск'.to_s, count: 2
    assert_select 'tr>td', text: 'ул. Ленина'.to_s, count: 1
    assert_select 'tr>td', text: 'ул. Усть-Балыкская'.to_s, count: 1
  end
end
