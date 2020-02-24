# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'addresses/show', type: :view do
  let(:city) { create(:city, name: 'Нефтеюганск') }
  let(:street) { create(:street, city: city, name: 'ул. Ленина') }
  let(:address) { create(:address, street: street, building_number: '72а') }

  it 'renders attributes in <p>' do
    assign(:address, address)

    render template: 'addresses/show', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.address.show.title',
                                        id: address.id, city: city.name, street: street.name),
                           count: 1

    expect(rendered).to match(I18n.t('views.address.show.title', id: address.id, city: city.name, street: street.name))

    expect(rendered).to match(/Нефтеюганск/)
    expect(rendered).to match(/ул. Ленина/)
    expect(rendered).to match(/72а/)
    expect(rendered).to match(/#{I18n.l(address.created_at, format: :short)}/)
    expect(rendered).to match(/#{I18n.l(address.updated_at, format: :short)}/)

    expect(response.body).to have_link(I18n.t('views.back'), href: addresses_path)
  end
end
