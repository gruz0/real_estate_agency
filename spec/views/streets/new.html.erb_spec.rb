require 'rails_helper'

RSpec.describe 'streets/new', type: :view do
  let(:city) { create(:city) }
  let(:street) { build(:street, city: city) }

  it 'renders new street form' do
    assign(:action, :post)
    assign(:city, city)
    assign(:street, street)

    render template: 'streets/new', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.street.new.title', city: city.name), count: 1
    assert_select 'h1', text: I18n.t('views.street.new.title', city: city.name), count: 1

    assert_select 'form[action=?][method=?]', city_streets_path(city), 'post' do
      assert_select 'input[name=?]', 'street[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.create'))
    expect(response.body).to have_link(I18n.t('views.back'), href: city_streets_path(city))
  end
end
