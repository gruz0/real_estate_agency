require 'rails_helper'

RSpec.describe 'estate_materials/index', type: :view do
  before(:each) do
    assign(:estate_materials, [
             EstateMaterial.create!(name: 'Деревянный'),
             EstateMaterial.create!(name: 'Кирпичный')
           ])
  end

  it 'renders a list of estate_materials' do
    render
    assert_select 'tr>td', text: 'Деревянный'.to_s, count: 1
    assert_select 'tr>td', text: 'Кирпичный'.to_s, count: 1
  end
end
