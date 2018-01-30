require 'rails_helper'

RSpec.describe 'layouts/application', type: :view do
  it 'renders a list of cities' do
    render

    assert_select 'title', text: I18n.t('views.layout.title')

    assert_select 'body > .navbar' do |navbar|
      expect(navbar).to have_link(I18n.t('views.layout.brand'), href: '/')

      assert_select 'ul.navbar-nav > li.nav-item' do |li|
        expect(li).to have_link(I18n.t('views.layout.menu.estates'), href: estates_path)
      end

      assert_select 'ul.navbar-nav > li.dropdown' do |dropdown|
        expect(dropdown).to have_link(I18n.t('views.layout.menu.dictionaries'), href: '#')

        assert_select('.dropdown-menu') do |menu|
          expect(menu).to have_link(I18n.t('views.layout.menu.clients'), href: clients_path)
          expect(menu).to have_link(I18n.t('views.layout.menu.employees'), href: employees_path)
          expect(menu).to have_link(I18n.t('views.layout.menu.estate_types'), href: estate_types_path)
          expect(menu).to have_link(I18n.t('views.layout.menu.estate_materials'), href: estate_materials_path)
          expect(menu).to have_link(I18n.t('views.layout.menu.estate_projects'), href: estate_projects_path)
          expect(menu).to have_link(I18n.t('views.layout.menu.cities'), href: cities_path)
        end
      end
    end
  end
end
