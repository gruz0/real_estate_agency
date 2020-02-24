# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'estate_materials/edit', type: :view do
  let(:estate_material) { create(:estate_material) }

  it 'renders the edit estate_material form' do
    assign(:estate_material, estate_material)

    render template: 'estate_materials/edit', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.estate_material.edit.title'), count: 1
    assert_select 'h1', text: I18n.t('views.estate_material.edit.title'), count: 1

    assert_select 'form[action=?][method=?]', estate_material_path(estate_material), 'post' do
      assert_select 'input[name=?]', 'estate_material[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.update'))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_materials_path)
  end
end
