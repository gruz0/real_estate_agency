require 'rails_helper'

RSpec.describe 'estate_types/edit', type: :view do
  let(:estate_type) { create(:estate_type) }

  it 'renders the edit estate_type form' do
    assign(:estate_type, estate_type)

    render template: 'estate_types/edit', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.estate_type.edit.title'), count: 1
    assert_select 'h1', text: I18n.t('views.estate_type.edit.title'), count: 1

    assert_select 'form[action=?][method=?]', estate_type_path(estate_type), 'post' do
      assert_select 'input[name=?]', 'estate_type[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.update'))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_types_path)
  end
end
