# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'services/reassign_estates', type: :view do
  it 'renders the reassign estates form' do
    render template: 'services/reassign_estates/index', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.services.reassign_estates.index.title'), count: 1
    assert_select 'h1', text: I18n.t('views.services.reassign_estates.index.title'), count: 1

    assert_select 'form[action=?][method=?]', services_reassign_estates_path, 'post' do
      assert_select 'select[name=?]', 'reassign_estates[from_employee]'
      assert_select 'select[name=?]', 'reassign_estates[to_employee]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.update'))
  end
end
