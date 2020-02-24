# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'layouts/application', type: :view do
  include PeopleHelper

  context 'when user is an employee' do
    login_employee

    it 'renders a layout' do
      flash[:notice] = 'Notice'
      flash[:alert] = 'Alert'

      render

      assert_select 'title', text: I18n.t('views.layout.title')

      assert_select 'body > .navbar' do |navbar|
        expect(navbar).to have_link(I18n.t('views.layout.brand'), href: '/')

        assert_select 'ul.navbar-nav > li.nav-item' do |li|
          expect(li).to have_link(I18n.t('views.layout.menu.estates'), href: estates_path)
          expect(li).not_to have_link(I18n.t('views.layout.menu.audits'), href: audits_path)
          expect(li).to have_link("#{I18n.t('views.layout.menu.logout')} (#{person_shortname(authenticated_employee)})",
                                  href: destroy_employee_session_path)
        end

        assert_select 'ul.navbar-nav > li.dropdown' do |dropdown|
          expect(dropdown).to have_link(I18n.t('views.layout.menu.dictionaries'), href: '#')
          expect(dropdown).not_to have_link(I18n.t('views.layout.menu.service'), href: '#')

          assert_select('.dropdown-menu') do |menu|
            expect(menu).to have_link(I18n.t('views.layout.menu.clients'), href: clients_path)
            expect(menu).not_to have_link(I18n.t('views.layout.menu.employees'), href: employees_path)
            expect(menu).to have_link(I18n.t('views.layout.menu.competitors'), href: competitors_path)
            expect(menu).to have_link(I18n.t('views.layout.menu.estate_types'), href: estate_types_path)
            expect(menu).to have_link(I18n.t('views.layout.menu.estate_materials'), href: estate_materials_path)
            expect(menu).to have_link(I18n.t('views.layout.menu.estate_projects'), href: estate_projects_path)
            expect(menu).to have_link(I18n.t('views.layout.menu.cities'), href: cities_path)
            expect(menu).not_to have_link(I18n.t('views.layout.menu.addresses'), href: addresses_path)
            expect(menu).not_to have_link(I18n.t('views.layout.menu.reassign_estates'),
                                          href: services_reassign_estates_path)
          end
        end
      end

      assert_select '.alert.alert-primary span', text: 'Notice', count: 1
      assert_select '.alert.alert-danger span', text: 'Alert', count: 1
    end
  end

  context 'when user is an admin' do
    login_admin

    it 'renders hidden menu items' do
      render

      assert_select 'body > .navbar' do |_navbar|
        assert_select 'ul.navbar-nav > li.nav-item' do |li|
          expect(li).not_to have_link(I18n.t('views.layout.menu.audits'), href: audits_path)
          expect(li).to have_link("#{I18n.t('views.layout.menu.logout')} (#{person_shortname(authenticated_admin)})",
                                  href: destroy_employee_session_path)
        end

        assert_select 'ul.navbar-nav > li.dropdown' do |dropdown|
          expect(dropdown).to have_link(I18n.t('views.layout.menu.service'), href: '#')

          assert_select('.dropdown-menu') do |menu|
            expect(menu).to have_link(I18n.t('views.layout.menu.employees'), href: employees_path)
            expect(menu).not_to have_link(I18n.t('views.layout.menu.addresses'), href: addresses_path)
            expect(menu).to have_link(I18n.t('views.layout.menu.reassign_estates'),
                                      href: services_reassign_estates_path)
          end
        end
      end
    end
  end

  context 'when user is an service_admin' do
    login_service_admin

    it 'renders hidden menu items' do
      render

      assert_select 'body > .navbar' do |_navbar|
        assert_select 'ul.navbar-nav > li.nav-item' do |li|
          expect(li).to have_link(I18n.t('views.layout.menu.audits'), href: audits_path)
          expect(li)
            .to have_link("#{I18n.t('views.layout.menu.logout')} (#{person_shortname(authenticated_service_admin)})",
                          href: destroy_employee_session_path)
        end

        assert_select 'ul.navbar-nav > li.dropdown' do |dropdown|
          expect(dropdown).to have_link(I18n.t('views.layout.menu.service'), href: '#')

          assert_select('.dropdown-menu') do |menu|
            expect(menu).to have_link(I18n.t('views.layout.menu.addresses'), href: addresses_path)
            expect(menu).to have_link(I18n.t('views.layout.menu.reassign_estates'),
                                      href: services_reassign_estates_path)
          end
        end
      end
    end
  end
end
