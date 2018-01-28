require 'rails_helper'

RSpec.describe 'estate_projects/index', type: :view do
  let(:estate_project1) { EstateProject.create!(name: 'Уральский') }
  let(:estate_project2) { EstateProject.create!(name: 'Ленинградский') }
  let(:estate_projects) { [estate_project1, estate_project2] }

  it 'renders a list of estate_projects' do
    assign(:estate_projects, estate_projects)

    render

    assert_select 'h1', text: I18n.t('views.estate_project.index.title'), count: 1

    expect(response.body).to have_link(I18n.t('views.estate_project.index.new'), href: new_estate_project_path)

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', text: EstateProject.human_attribute_name(:id), count: 1
        assert_select 'th', text: EstateProject.human_attribute_name(:name), count: 1
        assert_select 'th', text: EstateProject.human_attribute_name(:created_at), count: 1
        assert_select 'th', text: EstateProject.human_attribute_name(:updated_at), count: 1
      end

      assert_select 'tbody' do
        assert_select 'tr', count: 2
        assert_select 'tr>td', text: 'Уральский'.to_s, count: 1
        assert_select 'tr>td', text: 'Ленинградский'.to_s, count: 1
        assert_select 'tr td', text: estate_project1.created_at.to_s, count: 4
      end
    end

    estate_projects.each do |estate_project|
      expect(response.body).to have_link(I18n.t('views.show'), href: estate_project_path(estate_project))
      expect(response.body).to have_link(I18n.t('views.edit'), href: edit_estate_project_path(estate_project))
      expect(response.body).to have_link(I18n.t('views.destroy'), href: estate_project_path(estate_project))
    end
  end
end
