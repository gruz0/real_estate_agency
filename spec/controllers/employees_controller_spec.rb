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
      include_examples :employees_controller_allow_index_action_to_admins
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples :employees_controller_allow_index_action_to_admins
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
      include_examples :employees_controller_allow_show_action_to_admins
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples :employees_controller_allow_show_action_to_admins
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
      include_examples :employees_controller_allow_new_action_to_admins
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples :employees_controller_allow_new_action_to_admins
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
      include_examples :employees_controller_allow_edit_action_to_admins
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples :employees_controller_allow_edit_action_to_admins
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
      include_examples :employees_controller_allow_create_action_to_admins
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples :employees_controller_allow_create_action_to_admins
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
      include_examples :employees_controller_allow_update_action_to_admins
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples :employees_controller_allow_update_action_to_admins
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is an employee' do
      login_employee

      it 'redirects to root_path with alert' do
        delete :destroy, params: { id: employee.to_param }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('errors.messages.forbidden'))
      end
    end

    context 'when user is an admin' do
      login_admin
      include_examples :employees_controller_allow_destroy_action_to_admins
    end

    context 'when user is a service_admin' do
      login_service_admin
      include_examples :employees_controller_allow_destroy_action_to_admins
    end
  end
end
