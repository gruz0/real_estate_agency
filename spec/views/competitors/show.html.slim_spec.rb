require 'rails_helper'

RSpec.describe 'competitors/show', type: :view do
  let(:competitor) do
    create(:competitor, name: 'Сергей', phone_numbers: '+79991112233,111222')
  end

  it 'renders attributes in <p>' do
    assign(:competitor, competitor)

    render template: 'competitors/show', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.competitor.show.title', id: competitor.id), count: 1
    expect(rendered).to match(I18n.t('views.competitor.show.title', id: competitor.id))

    expect(rendered).to match(/Сергей/)
    expect(rendered).to match(/\+79991112233,111222/)
    expect(rendered).to match(/#{I18n.l(competitor.created_at, format: :short)}/)
    expect(rendered).to match(/#{I18n.l(competitor.updated_at, format: :short)}/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_competitor_path(competitor))
    expect(response.body).to have_link(I18n.t('views.back'), href: competitors_path)
  end
end
