require 'rails_helper'

RSpec.describe 'estate_types/index', type: :view do
  before(:each) do
    assign(:estate_types, [
             EstateType.create!(name: 'Квартира'),
             EstateType.create!(name: 'Дом')
           ])
  end

  it 'renders a list of estate_types' do
    render
    assert_select 'tr>td', text: 'Квартира'.to_s, count: 1
    assert_select 'tr>td', text: 'Дом'.to_s, count: 1
  end
end
