require 'rails_helper'

RSpec.describe 'estate_materials/show', type: :view do
  before(:each) do
    @estate_material = assign(:estate_material, EstateMaterial.create!(name: 'Деревянный'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Деревянный/)
  end
end
