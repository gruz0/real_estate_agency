require 'rails_helper'

RSpec.describe 'estate_materials/new', type: :view do
  before(:each) do
    assign(:estate_material, EstateMaterial.new(name: 'Деревянный'))
  end

  it 'renders new estate_material form' do
    render

    assert_select 'form[action=?][method=?]', estate_materials_path, 'post' do
      assert_select 'input[name=?]', 'estate_material[name]'
    end
  end
end
