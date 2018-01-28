require 'rails_helper'

RSpec.describe 'estate_types/show', type: :view do
  let(:estate_type) { create(:estate_type, name: 'Квартира') }

  it 'renders attributes in <p>' do
    assign(:estate_type, estate_type)

    render
    expect(rendered).to match(/Квартира/)
    expect(rendered).to match(/#{estate_type.created_at}/)
    expect(rendered).to match(/#{estate_type.updated_at}/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_estate_type_path(estate_type))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_types_path)
  end
end
