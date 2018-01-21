require 'rails_helper'

RSpec.describe 'estate_materials/edit', type: :view do
  before(:each) do
    @estate_material = assign(:estate_material, EstateMaterial.create!(name: 'Деревянный'))
  end

  it 'renders the edit estate_material form' do
    render

    assert_select 'form[action=?][method=?]', estate_material_path(@estate_material), 'post' do
      assert_select 'input[name=?]', 'estate_material[name]'
    end
  end
end
