require 'rails_helper'

RSpec.describe 'competitors/new', type: :view do
  let(:competitor) { build(:competitor) }

  it 'renders new competitor form' do
    assign(:competitor, competitor)

    render

    assert_select 'h1', text: I18n.t('views.competitor.new.title'), count: 1

    assert_select 'form[action=?][method=?]', competitors_path, 'post' do
      assert_select 'input[name=?]', 'competitor[phone_numbers]'

      assert_select 'input[name=?]', 'competitor[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.create'))
    expect(response.body).to have_link(I18n.t('views.back'), href: competitors_path)
  end
end
