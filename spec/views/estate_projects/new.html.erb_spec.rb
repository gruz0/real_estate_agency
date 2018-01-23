require 'rails_helper'

RSpec.describe 'estate_projects/new', type: :view do
  before(:each) do
    assign(:estate_project, EstateProject.new(name: 'Уральский'))
  end

  it 'renders new estate_project form' do
    render

    assert_select 'h1', text: I18n.t('views.estate_project.new.title'), count: 1

    assert_select 'form[action=?][method=?]', estate_projects_path, 'post' do
      assert_select 'input[name=?]', 'estate_project[name]'
    end

    expect(response.body).to have_button(I18n.t('helpers.submit.create'))
    expect(response.body).to have_link(I18n.t('views.back'), href: estate_projects_path)
  end
end
