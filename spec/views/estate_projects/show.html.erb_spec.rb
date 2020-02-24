# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'estate_projects/show', type: :view do
  let(:estate_project) { create(:estate_project, name: 'Уральский') }

  it 'renders attributes in <p>' do
    assign(:estate_project, estate_project)

    render template: 'estate_projects/show', layout: 'layouts/application'

    assert_select 'title', text: I18n.t('views.estate_project.show.title', id: estate_project.id), count: 1
    expect(rendered).to match(I18n.t('views.estate_project.show.title', id: estate_project.id))

    expect(rendered).to match(/Уральский/)
    expect(rendered).to match(/#{I18n.l(estate_project.created_at, format: :short)}/)
    expect(rendered).to match(/#{I18n.l(estate_project.updated_at, format: :short)}/)

    expect(response.body).to have_link(I18n.t('views.edit'), href: edit_estate_project_path(estate_project))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_projects_path)
  end
end
