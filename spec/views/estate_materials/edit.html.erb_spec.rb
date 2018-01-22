require 'rails_helper'

RSpec.describe 'estate_materials/edit', type: :view do
  before(:each) do
    @estate_material = assign(:estate_material, EstateMaterial.create!(name: 'Деревянный'))
  end

  it 'renders the edit estate_material form' do
    render

    assert_select 'h1', text: I18n.t('views.estate_material.edit.title'), count: 1

    assert_select 'form[action=?][method=?]', estate_material_path(@estate_material), 'post' do
      assert_select 'input[name=?]', 'estate_material[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.update'))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_materials_path)
  end
end
