# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let(:employee) { Employee.create! valid_attributes }

  let(:valid_attributes) do
    attributes_for(:employee)
  end

  let(:invalid_attributes) do
    {
      email: '',
      password: '',
      last_name: '',
      first_name: '',
      phone_numbers: ''
    }
  end

  describe 'GET #index' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        get :index, params: {}
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin
      include_examples 'employees controller allow index action to admins'
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples 'employees controller allow index action to admins'
    end
  end

  describe 'GET #show' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        get :show, params: { id: employee.to_param }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin
      include_examples 'employees controller allow show action to admins'
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples 'employees controller allow show action to admins'
    end
  end

  describe 'GET #new' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        get :new, params: {}
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin
      include_examples 'employees controller allow new action to admins'
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples 'employees controller allow new action to admins'
    end
  end

  describe 'GET #edit' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        get :edit, params: { id: employee.to_param }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin

      context 'when editable user is an employee' do
        include_examples 'employees controller allow edit action to admins'
      end

      context 'when editable user is a service_admin' do
        it 'redirects to root_path with alert' do
          employee.update!(role: :service_admin)

          get :edit, params: { id: employee.to_param }
          expect(response).to be_redirect
          expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
        end
      end
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples 'employees controller allow edit action to admins'
    end
  end

  describe 'POST #create' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        post :create, params: { employee: valid_attributes }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin

      context 'when new user is an employee' do
        include_examples 'employees controller allow create action to admins'
      end

      context 'when new user is a service_admin' do
        it 'redirects to root_path with alert' do
          post :create, params: { employee: valid_attributes.merge(role: :service_admin) }
          expect(response).to be_redirect
          expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
        end
      end
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples 'employees controller allow create action to admins'
    end
  end

  describe 'PUT #update' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        put :update, params: { id: employee.to_param, employee: {} }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin

      context 'when updateable user is an employee' do
        include_examples 'employees controller allow update action to admins'
      end

      context 'when updateable user is a service_admin' do
        it 'redirects to root_path with alert' do
          new_attributes = {
            last_name: FFaker::NameRU.last_name,
            first_name: FFaker::NameRU.first_name,
            middle_name: FFaker::NameRU.middle_name_male,
            phone_numbers: FFaker::PhoneNumber.phone_number,
            role: 'service_admin'
          }

          put :update, params: { id: employee.to_param, employee: new_attributes }
          expect(response).to be_redirect
          expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
        end
      end

      context 'when change role to service_admin for updating user' do
        it 'redirects to root_path with alert' do
          employee.update!(role: :service_admin)

          new_attributes = {
            last_name: FFaker::NameRU.last_name,
            first_name: FFaker::NameRU.first_name,
            middle_name: FFaker::NameRU.middle_name_male,
            phone_numbers: FFaker::PhoneNumber.phone_number,
            role: 'service_admin'
          }

          put :update, params: { id: employee.to_param, employee: new_attributes }
          expect(response).to be_redirect
          expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
        end
      end
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples 'employees controller allow update action to admins'
    end
  end

  describe 'POST #lock' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        post :lock, params: { id: employee.to_param }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin

      context 'when lockable user is an employee' do
        include_examples 'employees controller allow lock action to admins'
      end

      context 'when try to lock himself' do
        let(:current_employee) { authenticated_admin }

        include_examples 'employees controller prevent to lock yourself'
      end

      context 'when lockable user is a service_admin' do
        it 'redirects to root_path with alert' do
          employee.update!(role: :service_admin)

          post :lock, params: { id: employee.to_param }
          expect(response).to be_redirect
          expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
        end
      end
    end

    context 'when user is a service_admin' do
      login_service_admin

      context 'when lockable user is an employee' do
        include_examples 'employees controller allow lock action to admins'
      end

      context 'when try to lock himself' do
        let(:current_employee) { authenticated_service_admin }

        include_examples 'employees controller prevent to lock yourself'
      end
    end
  end

  describe 'POST #unlock' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        post :unlock, params: { id: employee.to_param }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin

      context 'when unlockable user is an employee' do
        include_examples 'employees controller allow unlock action to admins'
      end

      context 'when try to unlock himself' do
        let(:current_employee) { authenticated_admin }

        include_examples 'employees controller prevent to unlock yourself'
      end

      context 'when unlockable user is a service_admin' do
        it 'redirects to root_path with alert' do
          employee.update!(role: :service_admin)

          post :unlock, params: { id: employee.to_param }
          expect(response).to be_redirect
          expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
        end
      end
    end

    context 'when user is a service_admin' do
      login_service_admin

      context 'when unlockable user is an employee' do
        include_examples 'employees controller allow unlock action to admins'
      end

      context 'when try to unlock himself' do
        let(:current_employee) { authenticated_service_admin }

        include_examples 'employees controller prevent to unlock yourself'
      end
    end
  end
end
