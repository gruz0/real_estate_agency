# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'estate_materials/new', type: :view do
  it 'renders new estate_material form' do
    assign(:estate_material, build(:estate_material))

    render template: 'estate_materials/new', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.estate_material.new.title'), count: 1
    assert_select 'h1', text: I18n.t('views.estate_material.new.title'), count: 1

    assert_select 'form[action=?][method=?]', estate_materials_path, 'post' do
      assert_select 'input[name=?]', 'estate_material[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.create'))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_materials_path)
  end
end
