# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'estate_projects/edit', type: :view do
  let(:estate_project) { create(:estate_project) }

  it 'renders the edit estate_project form' do
    assign(:estate_project, estate_project)

    render template: 'estate_projects/edit', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.estate_project.edit.title'), count: 1
    assert_select 'h1', text: I18n.t('views.estate_project.edit.title'), count: 1

    assert_select 'form[action=?][method=?]', estate_project_path(estate_project), 'post' do
      assert_select 'input[name=?]', 'estate_project[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.update'))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_projects_path)
  end
end
