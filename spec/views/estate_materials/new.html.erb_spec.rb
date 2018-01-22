require 'rails_helper'

RSpec.describe 'estate_materials/new', type: :view do
  before(:each) do
    assign(:estate_material, EstateMaterial.new(name: 'Деревянный'))
  end

  it 'renders new estate_material form' do
    render

    assert_select 'h1', text: I18n.t('views.estate_material.new.title'), count: 1

    assert_select 'form[action=?][method=?]', estate_materials_path, 'post' do
      assert_select 'input[name=?]', 'estate_material[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.create'))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_materials_path)
  end
end
