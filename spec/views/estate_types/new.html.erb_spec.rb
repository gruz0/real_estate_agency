# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'estate_types/new', type: :view do
  it 'renders new estate_type form' do
    assign(:estate_type, build(:estate_type))

    render template: 'estate_types/new', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.estate_type.new.title'), count: 1
    assert_select 'h1', text: I18n.t('views.estate_type.new.title'), count: 1

    assert_select 'form[action=?][method=?]', estate_types_path, 'post' do
      assert_select 'input[name=?]', 'estate_type[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.create'))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_types_path)
  end
end
