require 'rails_helper'

RSpec.describe 'competitors/edit', type: :view do
  let(:competitor) { create(:competitor) }

  it 'renders the edit competitor form' do
    assign(:competitor, competitor)

    render template: 'competitors/edit', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.competitor.edit.title'), count: 1
    assert_select 'h1', text: I18n.t('views.competitor.edit.title'), count: 1

    assert_select 'form[action=?][method=?]', competitor_path(competitor), 'post' do
      assert_select 'input[name=?]', 'competitor[phone_numbers]'

      assert_select 'input[name=?]', 'competitor[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.update'))
    expect(response.body).to have_link(I18n.t('views.back'), href: competitors_path)
  end
end
