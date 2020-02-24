# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'estate_materials/show', type: :view do
  let(:estate_material) { create(:estate_material, name: 'Деревянный') }

  it 'renders attributes in <p>' do
    assign(:estate_material, estate_material)

    render template: 'estate_materials/show', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.estate_material.show.title', id: estate_material.id), count: 1
    expect(rendered).to match(I18n.t('views.estate_material.show.title', id: estate_material.id))

    expect(rendered).to match(/Деревянный/)
    expect(rendered).to match(/#{I18n.l(estate_material.created_at, format: :short)}/)
    expect(rendered).to match(/#{I18n.l(estate_material.updated_at, format: :short)}/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_estate_material_path(estate_material))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_materials_path)
  end
end
