# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'cities/new', type: :view do
  it 'renders new city form' do
    assign(:city, build(:city))

    render template: 'cities/new', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.city.new.title'), count: 1
    assert_select 'h1', text: I18n.t('views.city.new.title'), count: 1

    assert_select 'form[action=?][method=?]', cities_path, 'post' do
      assert_select 'input[name=?]', 'city[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.create'))
    expect(response.body).to have_link(I18n.t('views.back'), href: cities_path)
  end
end
