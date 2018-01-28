require 'rails_helper'

RSpec.describe 'estate_materials/show', type: :view do
  let(:estate_material) { create(:estate_material, name: 'Деревянный') }

  it 'renders attributes in <p>' do
    assign(:estate_material, estate_material)

    render

    expect(rendered).to match(/Деревянный/)
    expect(rendered).to match(/#{estate_material.created_at}/)
    expect(rendered).to match(/#{estate_material.updated_at}/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_estate_material_path(estate_material))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_materials_path)
  end
end
