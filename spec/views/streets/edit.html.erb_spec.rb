# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'streets/edit', type: :view do
  let(:city) { create(:city) }
  let(:street) { create(:street, city: city) }

  it 'renders the edit street form' do
    assign(:action, :put)
    assign(:city, city)
    assign(:street, street)

    render template: 'streets/edit', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.street.edit.title', city: city.name), count: 1
    assert_select 'h1', text: I18n.t('views.street.edit.title', city: city.name), count: 1

    assert_select 'form[action=?][method=?]', city_street_path(city, street), 'post' do
      assert_select 'input[name=?]', 'street[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.update'))
    expect(response.body).to have_link(I18n.t('views.back'), href: city_streets_path(city))
  end
end
