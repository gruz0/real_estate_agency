require 'rails_helper'

RSpec.describe 'estate_materials/show', type: :view do
  before(:each) do
    @estate_material = assign(:estate_material, EstateMaterial.create!(name: 'Деревянный'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Деревянный/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_estate_material_path(@estate_material))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_materials_path)
  end
end
